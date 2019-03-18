SET FOREIGN_KEY_CHECKS=0;

LOAD DATA LOCAL INFILE '/home/fomodei/Luca Violato - Federico Omodei/Popolamento/Item.tsv' REPLACE INTO TABLE Item FIELDS TERMINATED BY '\t' ENCLOSED BY "'";

LOAD DATA LOCAL INFILE '/home/fomodei/Luca Violato - Federico Omodei/Popolamento/Arma.tsv' REPLACE INTO TABLE Arma FIELDS TERMINATED BY '\t' ENCLOSED BY "'";

LOAD DATA LOCAL INFILE '/home/fomodei/Luca Violato - Federico Omodei/Popolamento/Mostro.tsv' REPLACE INTO TABLE Mostro FIELDS TERMINATED BY '\t' ENCLOSED BY "'";

LOAD DATA LOCAL INFILE '/home/fomodei/Luca Violato - Federico Omodei/Popolamento/AreaInfernale.tsv' REPLACE INTO TABLE AreaInfernale FIELDS TERMINATED BY '\t' ENCLOSED BY "'";

LOAD DATA LOCAL INFILE '/home/fomodei/Luca Violato - Federico Omodei/Popolamento/Regione.tsv' REPLACE INTO TABLE Regione FIELDS TERMINATED BY '\t' ENCLOSED BY "'";

LOAD DATA LOCAL INFILE '/home/fomodei/Luca Violato - Federico Omodei/Popolamento/ItemDrop.tsv' REPLACE INTO TABLE ItemDrop FIELDS TERMINATED BY '\t' ENCLOSED BY "'";

LOAD DATA LOCAL INFILE '/home/fomodei/Luca Violato - Federico Omodei/Popolamento/MostroLeggendario.tsv' REPLACE INTO TABLE MostroLeggendario FIELDS TERMINATED BY '\t' ENCLOSED BY "'";

LOAD DATA LOCAL INFILE '/home/fomodei/Luca Violato - Federico Omodei/Popolamento/MostroInfernale.tsv' REPLACE INTO TABLE MostroInfernale FIELDS TERMINATED BY '\t' ENCLOSED BY "'";

LOAD DATA LOCAL INFILE '/home/fomodei/Luca Violato - Federico Omodei/Popolamento/Origine.tsv' REPLACE INTO TABLE Origine FIELDS TERMINATED BY '\t' ENCLOSED BY "'";

LOAD DATA LOCAL INFILE '/home/fomodei/Luca Violato - Federico Omodei/Popolamento/Localita.tsv' REPLACE INTO TABLE Localita FIELDS TERMINATED BY '\t' ENCLOSED BY "'";

LOAD DATA LOCAL INFILE '/home/fomodei/Luca Violato - Federico Omodei/Popolamento/LocalitaOstile.tsv' REPLACE INTO TABLE LocalitaOstile FIELDS TERMINATED BY '\t' ENCLOSED BY "'";

LOAD DATA LOCAL INFILE '/home/fomodei/Luca Violato - Federico Omodei/Popolamento/Faglia.tsv' REPLACE INTO TABLE Faglia FIELDS TERMINATED BY '\t' ENCLOSED BY "'";

LOAD DATA LOCAL INFILE '/home/fomodei/Luca Violato - Federico Omodei/Popolamento/InsediamentoAbitato.tsv' REPLACE INTO TABLE InsediamentoAbitato FIELDS TERMINATED BY '\t' ENCLOSED BY "'";

LOAD DATA LOCAL INFILE '/home/fomodei/Luca Violato - Federico Omodei/Popolamento/Eroe.tsv' REPLACE INTO TABLE Eroe FIELDS TERMINATED BY '\t' ENCLOSED BY "'";

LOAD DATA LOCAL INFILE '/home/fomodei/Luca Violato - Federico Omodei/Popolamento/GodSlayer.tsv' REPLACE INTO TABLE GodSlayer FIELDS TERMINATED BY '\t' ENCLOSED BY "'";

LOAD DATA LOCAL INFILE '/home/fomodei/Luca Violato - Federico Omodei/Popolamento/SquadraAttuale.tsv' REPLACE INTO TABLE SquadraAttuale FIELDS TERMINATED BY '\t' ENCLOSED BY "'";

LOAD DATA LOCAL INFILE '/home/fomodei/Luca Violato - Federico Omodei/Popolamento/SquadraPassata.tsv' REPLACE INTO TABLE SquadraPassata FIELDS TERMINATED BY '\t' ENCLOSED BY "'";

LOAD DATA LOCAL INFILE '/home/fomodei/Luca Violato - Federico Omodei/Popolamento/MembroPassato.tsv' REPLACE INTO TABLE MembroPassato FIELDS TERMINATED BY '\t' ENCLOSED BY "'";

LOAD DATA LOCAL INFILE '/home/fomodei/Luca Violato - Federico Omodei/Popolamento/Boss.tsv' REPLACE INTO TABLE Boss FIELDS TERMINATED BY '\t' ENCLOSED BY "'";

LOAD DATA LOCAL INFILE '/home/fomodei/Luca Violato - Federico Omodei/Popolamento/ArmaUnica.tsv' REPLACE INTO TABLE ArmaUnica FIELDS TERMINATED BY '\t' ENCLOSED BY "'";

LOAD DATA LOCAL INFILE '/home/fomodei/Luca Violato - Federico Omodei/Popolamento/Mercante.tsv' REPLACE INTO TABLE Mercante FIELDS TERMINATED BY '\t' ENCLOSED BY "'";

LOAD DATA LOCAL INFILE '/home/fomodei/Luca Violato - Federico Omodei/Popolamento/InVendita.tsv' REPLACE INTO TABLE InVendita FIELDS TERMINATED BY '\t' ENCLOSED BY "'";

LOAD DATA LOCAL INFILE '/home/fomodei/Luca Violato - Federico Omodei/Popolamento/Habitat.tsv' REPLACE INTO TABLE Habitat FIELDS TERMINATED BY '\t' ENCLOSED BY "'";

LOAD DATA LOCAL INFILE '/home/fomodei/Luca Violato - Federico Omodei/Popolamento/Inventario.tsv' REPLACE INTO TABLE Inventario FIELDS TERMINATED BY '\t' ENCLOSED BY "'";

LOAD DATA LOCAL INFILE '/home/fomodei/Luca Violato - Federico Omodei/Popolamento/Appartenenza.tsv' REPLACE INTO TABLE Appartenenza FIELDS TERMINATED BY '\t' ENCLOSED BY "'";

SET FOREIGN_KEY_CHECKS=1;
