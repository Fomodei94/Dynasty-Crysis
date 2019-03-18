1)
select 		SquadraAttuale.Nome as NomeSquadra, SquadraAttuale.Leader as Leader
from 		SquadraAttuale join Eroe on SquadraAttuale.Nome=Eroe.Squadra
group by 	SquadraAttuale.Nome
having 		count(Eroe.Nome)>=5 and count(distinct Eroe.Classe)<= all (select	 	count(distinct Eroe.Classe)
																		from 		SquadraAttuale join Eroe on SquadraAttuale.Nome=Eroe.Squadra
																		group by 	SquadraAttuale.Nome)
order by 	SquadraAttuale.Nome;

2)
select 		Eroe.Nome as Nome, Eroe.Squadra as Squadra, count(ArmaUnica.CodiceArma) as NumeroArmiUniche
from 		Eroe join Appartenenza on Eroe.Nome=Appartenenza.Inventario
			join Item on Appartenenza.Item=Item.Codice
			join ArmaUnica on Appartenenza.Item=ArmaUnica.CodiceArma
			left join SquadraAttuale on Eroe.Squadra=SquadraAttuale.Nome
group by 	Eroe.Nome
having 		count(*) >= all (select 	count(*)
							from 		Eroe join Appartenenza on Eroe.Nome=Appartenenza.Inventario
										join ArmaUnica on Appartenenza.Item=ArmaUnica.CodiceArma
							group by 	Eroe.Nome)
order by 	Eroe.Livello desc;

3)
select 		Eroe.Nome as Nome, Eroe.Livello as Livello, Eroe.Classe as Classe
from 		Eroe
where 		Eroe.Squadra is null and not exists (select *
												from 	 MembroPassato
												where	 MembroPassato.Eroe=Eroe.Nome
												)
order by Eroe.Livello desc, Eroe.Nome;

4)
select 		SquadraAttuale.Nome as NomeSquadra, sum(Eroe.Denaro)+sum(Item.Valore) as Patrimonio
from 		Eroe join SquadraAttuale on Eroe.Squadra=SquadraAttuale.Nome
			join Appartenenza on Eroe.Nome=Appartenenza.Inventario
			join Item on Appartenenza.Item=Item.Codice
where 		SquadraAttuale.Speciale='S'
group by 	SquadraAttuale.Nome;

5)
create view PrezzoMedio (Media, Insediamento) as
select 		avg(Item.Valore), InsediamentoAbitato.Nome
from 		InsediamentoAbitato join InVendita on InsediamentoAbitato.Nome=InVendita.LuogoNegozio
			join Item on InVendita.Item=Item.Codice	
group by 	InsediamentoAbitato.Nome;

select 		Insediamento, Media
from 		PrezzoMedio
having 		Media = any (select max(Media)
						from PrezzoMedio
						)
order by 	Insediamento;
