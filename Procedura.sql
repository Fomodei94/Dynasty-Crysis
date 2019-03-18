delimiter $$
DROP PROCEDURE IF EXISTS Acquisto $$
CREATE PROCEDURE Acquisto(E varchar(30), I char(8), Me varchar(30), L varchar(30))

BEGIN

declare Prezzo int;
declare Disponibilita int;

select Valore into Prezzo
from Item
where Codice=I;

select Denaro into Disponibilita
from Eroe
where Nome=E;

IF Disponibilita >= Prezzo
	then
	insert Appartenenza values (E, I);
	
	update Eroe set Denaro=Disponibilita-Prezzo where Nome=E;
	
	delete from InVendita where Item=I and Mercante=Me and LuogoNegozio=L;
	
	else
	signal sqlstate '45000'
	set message_text = 'Denaro insufficiente per acquistare';
	
END IF;

END; $$

delimiter ;
