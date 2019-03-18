delimiter $$
DROP TRIGGER IF EXISTS VerificaDropArmaUnica $$
CREATE TRIGGER VerificaDropArmaUnica
BEFORE INSERT ON ArmaUnica
FOR EACH ROW

BEGIN
declare Y char(8);
declare Z smallint;

select Mostro, DropRate into Y, Z
from ItemDrop
where Item=new.CodiceArma;

IF not exists (select Item from ItemDrop where Item=new.CodiceArma)
	then
	insert into ItemDrop values (new.CodiceArma, new.DropBoss, 100);
END IF;

IF  Y != new.DropBoss or Z != 100
	then
	signal sqlstate '45000'
	set message_text = 'Corrispondente tupla in ItemDrop scorretta';

END IF;

END; $$

DROP TRIGGER IF EXISTS VerificaDropArmaUnica2 $$
CREATE TRIGGER VerificaDropArmaUnica2
BEFORE INSERT ON ItemDrop
FOR EACH ROW

BEGIN

IF exists (select * from ItemDrop join ArmaUnica on ItemDrop.Item=ArmaUnica.CodiceArma where ItemDrop.Item=new.Item)
	then
	signal sqlstate '45000'
	set message_text = 'Erroe! Ogni ArmaUnica puo essere droppata da uno e un solo Boss!';
END IF;

IF exists (select * from ItemDrop join Boss on ItemDrop.Mostro=Boss.Codice where ItemDrop.Mostro=new.Mostro)
	then
	signal sqlstate '45000'
	set message_text = 'Errore! Ogni Boss puo droppare unicamente la sua ArmaUnica!';
END IF;

IF exists (select * from ArmaUnica where CodiceArma=new.Item) and new.DropRate != 100
	then
	signal sqlstate '45000'
	set message_text = 'Errore! Ogni ArmaUnica viene droppata con % DropRate = 100!';
END IF;

END; $$

DROP TRIGGER IF EXISTS PromozioneSquadra $$
CREATE TRIGGER PromozioneSquadra
AFTER INSERT ON GodSlayer
FOR EACH ROW

BEGIN
UPDATE SquadraAttuale SET Speciale='S' where Leader=new.Nome;
END; $$

DROP TRIGGER IF EXISTS EliminaEroe $$
CREATE TRIGGER EliminaEroe
BEFORE DELETE ON Eroe
FOR EACH ROW

BEGIN
declare X varchar(30);
select SquadraAttuale.Nome into X
from SquadraAttuale
where SquadraAttuale.Leader=old.Nome;

insert SquadraPassata values (X, NULL, NULL);

END; $$

DROP TRIGGER IF EXISTS VecchioMembro $$
CREATE TRIGGER VecchioMembro
AFTER INSERT ON SquadraPassata
FOR EACH ROW

BEGIN

insert into MembroPassato
	select Eroe.Squadra, Eroe.Nome
	from Eroe
	where Squadra=new.Nome;

delete from SquadraAttuale where Nome=new.Nome;
END; $$

DROP TRIGGER IF EXISTS ControllaAppartenenza $$
CREATE TRIGGER ControllaAppartenenza
BEFORE INSERT ON Appartenenza
FOR EACH ROW

BEGIN
declare X smallint;
declare Y smallint;
declare Z int;

select sum(Item.Peso) into X
from Item join Appartenenza on Item.Codice=Appartenenza.Item
where Appartenenza.Inventario=new.Inventario
group by Appartenenza.Inventario;


select Item.Peso into Y
from Item 
where Item.Codice=new.Item;

select Inventario.Capienza into Z
from Inventario 
where Inventario.Proprietario=new.Inventario;

IF X + Y > Z
	then
	signal sqlstate '45000'
	set message_text = 'Capienza Massima inventario superata';
	
END IF;

IF exists (select Item from Appartenenza where Item=new.Item)
	then
	
	signal sqlstate '45000'
	set message_text = 'Item gia in possesso di un altro Eroe';

END IF;

IF exists (select Item from ItemDrop where Item=new.Item)
	then
	delete from ItemDrop where Item=new.Item;

END IF;

END; $$

DROP TRIGGER IF EXISTS AssociaLeader $$
CREATE TRIGGER AssociaLeader
AFTER INSERT ON SquadraAttuale
FOR EACH ROW

BEGIN

update Eroe set Eroe.Squadra=new.Nome where Eroe.Nome=new.Leader;

END; $$

DROP TRIGGER IF EXISTS ControllaVendita $$
CREATE TRIGGER ControllaVendita
BEFORE INSERT ON InVendita
FOR EACH ROW

BEGIN

IF exists (select Item from ItemDrop where Item=new.Item)
	then
	signal sqlstate '45000'
	set message_text = 'Errore! Item impossibile da mettere in vendita perche Droppabile da un Mostro';

END IF;

IF exists (select Item from Appartenenza where Item=new.Item)
	then
	
	signal sqlstate '45000'
	set message_text = 'Item gia in possesso di un Eroe';

END IF;

END; $$

DROP TRIGGER IF EXISTS ControllaNumMembri $$
CREATE TRIGGER ControllaNumMembri
BEFORE UPDATE ON Eroe
FOR EACH ROW

BEGIN

declare N smallint;

select count(*) into N
from Eroe
where Squadra=new.Squadra
group by Squadra;

IF N > 5
	then
	signal sqlstate '45000'
	set message_text = 'Numero massimo di membri (6) superato per una Squadra';
END IF;

END; $$

DROP TRIGGER IF EXISTS ControllaNumMembri2 $$
CREATE TRIGGER ControllaNumMembri2
BEFORE INSERT ON Eroe
FOR EACH ROW

BEGIN

declare N smallint;

select count(*) into N
from Eroe
where Squadra=new.Squadra
group by Squadra;

IF N > 5
	then
	signal sqlstate '45000'
	set message_text = 'Numero massimo di membri (6) superato per una Squadra';
END IF;

END; $$

delimiter ;
