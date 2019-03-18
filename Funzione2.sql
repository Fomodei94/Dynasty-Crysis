delimiter $$
DROP FUNCTION IF EXISTS CittaNatale $$
CREATE FUNCTION CittaNatale(minMAX ENUM('min','MAX') )
RETURNS VARCHAR(30) DETERMINISTIC

BEGIN
declare Citta varchar(30);

IF minMAX='min'
	then
	select InsediamentoAbitato.Nome into Citta
	from InsediamentoAbitato join Eroe on InsediamentoAbitato.Nome=Eroe.LuogoNascita
	group by InsediamentoAbitato.Nome
	having count(Eroe.Nome) <= all
								(select count(Eroe.Nome)  
								from InsediamentoAbitato join Eroe on InsediamentoAbitato.Nome=Eroe.LuogoNascita
								group by InsediamentoAbitato.Nome )
	limit 1;
	
	elseif minMAX='MAX'
	then
	select InsediamentoAbitato.Nome into Citta
	from InsediamentoAbitato join Eroe on InsediamentoAbitato.Nome=Eroe.LuogoNascita
	group by InsediamentoAbitato.Nome
	having count(Eroe.Nome) >= all
								(select count(Eroe.Nome)  
								from InsediamentoAbitato join Eroe on InsediamentoAbitato.Nome=Eroe.LuogoNascita
								group by InsediamentoAbitato.Nome )
	limit 1;
	
END IF;

RETURN Citta;

END $$

delimiter ;
