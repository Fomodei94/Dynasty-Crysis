delimiter $$
DROP FUNCTION IF EXISTS ValoreItemMercante $$
CREATE FUNCTION ValoreItemMercante(Nome_Mercante varchar(30), Luogo_Negozio varchar(30) )
RETURNS INTEGER DETERMINISTIC

BEGIN
declare totale INT;

select sum(Item.Valore) into totale
from InVendita join Item on InVendita.Item=Item.Codice
where InVendita.Mercante=Nome_Mercante and InVendita.LuogoNegozio=Luogo_Negozio;

RETURN totale;

END; $$

delimiter ;
