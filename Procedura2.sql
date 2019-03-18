delimiter $$
DROP PROCEDURE IF EXISTS Fusione $$
CREATE PROCEDURE Fusione(S1 varchar(30), S2 varchar(30), NuovaSquadra varchar(30))

BEGIN

declare N1 smallint;
declare N2 smallint;
declare E varchar(30);
declare S char;
declare L1 varchar(30);
declare L2 varchar(30);

select count(Nome) into N1
from Eroe
where Squadra=S1;

select count(Nome) into N2
from Eroe
where Squadra=S2;

IF N1 + N2 <= 6
	then
	select Eroe.Nome, SquadraAttuale.Speciale into E, S
	from Eroe join SquadraAttuale on SquadraAttuale.Leader=Eroe.Nome
	where SquadraAttuale.Nome=S1 or SquadraAttuale.Nome=S2
	order by Eroe.Livello desc
	limit 1;

	
	select Leader into L1
	from SquadraAttuale 
	where Nome=S1;
	
	select Leader into L2
	from SquadraAttuale 
	where Nome=S2;
	
	insert SquadraPassata values (S1, NULL, L1);
	insert SquadraPassata values (S2, NULL, L2);
	
	insert SquadraAttuale values (NuovaSquadra, E, S);
	
	update Eroe set Squadra=NuovaSquadra where Squadra is null and Nome in (select Eroe from MembroPassato where Squadra=S1 or Squadra=S2);
	
	else 
	signal sqlstate '45000'
	set message_text = 'Numero Massimo Membri Superato';
END IF;

END; $$

delimiter ;

