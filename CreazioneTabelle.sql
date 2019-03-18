DROP TABLE IF EXISTS Mostro;
create table Mostro (
Codice char(8) primary key,
Nome varchar(30) not null,
Tipologia varchar(12),
Rarita varchar(12),
Esperienza int default 0
) ENGINE= InnoDB CHARSET= latin1;

DROP TABLE IF EXISTS Item;
create table Item (
Codice char(8) primary key,
Nome varchar(40) not null,
Tipo varchar(12),
Rarita varchar(12),
Peso smallint not null default 1,
Valore int default 0
) ENGINE= InnoDB CHARSET= latin1;

DROP TABLE IF EXISTS AreaInfernale;
create table AreaInfernale (
Nome varchar(30) primary key
) ENGINE= InnoDB CHARSET= latin1;

DROP TABLE IF EXISTS Regione;
create table Regione (
Nome varchar(30) primary key
) ENGINE= InnoDB CHARSET= latin1;

DROP TABLE IF EXISTS ItemDrop;
create table ItemDrop (
Item char(8),
Mostro char(8), 
DropRate smallint,
primary key(Item, Mostro),
foreign key (Item) references Item(Codice)
	on update cascade
	on delete no action,
foreign key (Mostro) references Mostro(Codice)
	on update cascade
	on delete cascade
) ENGINE= InnoDB CHARSET= latin1;

DROP TABLE IF EXISTS Arma;
create table Arma (
Codice char(8) primary key,
Tipo varchar(12),
Danno smallint,
Resistenza smallint,
foreign key (Codice) references Item(Codice)
	on update cascade
	on delete no action
) ENGINE= InnoDB CHARSET= latin1;

DROP TABLE IF EXISTS MostroLeggendario;
create table MostroLeggendario (
Codice char(8) primary key,
Stato char default 'V',
foreign key (Codice) references Mostro(Codice)
	on update cascade
	on delete no action
) ENGINE= InnoDB CHARSET= latin1;

DROP TABLE IF EXISTS MostroInfernale;
create table MostroInfernale (
Codice char(8) primary key,
foreign key (Codice) references Mostro(Codice)
	on update cascade
	on delete cascade 
) ENGINE= InnoDB CHARSET= latin1;

DROP TABLE IF EXISTS Origine;
create table Origine (
MostroInfernale char(8),
Area varchar(30),
primary key(MostroInfernale, Area),
foreign key (MostroInfernale) references MostroInfernale(Codice)
	on update cascade
	on delete no action,
foreign key (Area) references AreaInfernale(Nome)
	on update cascade
	on delete no action
) ENGINE= InnoDB CHARSET= latin1;

DROP TABLE IF EXISTS Localita;
create table Localita (
Nome varchar(30) primary key,
Clima varchar(12),
Regione varchar(30),
foreign key (Regione) references Regione(Nome)
	on update cascade
	on delete no action
) ENGINE= InnoDB CHARSET= latin1;

DROP TABLE IF EXISTS LocalitaOstile;
create table LocalitaOstile (
Nome varchar(30) primary key,
foreign key (Nome) references Localita(Nome)
	on update cascade
	on delete no action
) ENGINE= InnoDB CHARSET= latin1;

DROP TABLE IF EXISTS Faglia;
create table Faglia (
Codice char(8) primary key,
Destinazione varchar(30) not null,
Posizione varchar(30),
foreign key (Destinazione) references AreaInfernale(Nome)
	on update cascade
	on delete no action,
foreign key (Posizione) references Localita(Nome)
	on update cascade
	on delete cascade
) ENGINE= InnoDB CHARSET= latin1;

DROP TABLE IF EXISTS InsediamentoAbitato;
create table InsediamentoAbitato (
Nome varchar(30) primary key,
NumAbitanti int,
Tipologia varchar(12),
Localita varchar(30),
foreign key (Localita) references Localita(Nome)
	on update cascade
	on delete no action
) ENGINE= InnoDB CHARSET= latin1;

DROP TABLE IF EXISTS Eroe;
create table Eroe (
Nome varchar(30) primary key,
Denaro int,
Livello smallint default 1,
Classe varchar(12) not null,
LuogoNascita varchar(30),
DataNascita date,
Squadra varchar(30),
foreign key (LuogoNascita) references InsediamentoAbitato(Nome)
	on update cascade
	on delete no action
) ENGINE= InnoDB CHARSET= latin1;

DROP TABLE IF EXISTS GodSlayer;
create table GodSlayer (
Nome varchar(30) primary key,
LeggendarioUcciso char(8) not null,
DataUccisione date,
foreign key (Nome) references Eroe(Nome)
	on update cascade
	on delete cascade,
foreign key (LeggendarioUcciso) references MostroLeggendario(Codice)
	on update cascade
	on delete no action
) ENGINE= InnoDB CHARSET= latin1;

DROP TABLE IF EXISTS SquadraAttuale;
create table SquadraAttuale (
Nome varchar(30) primary key,
Leader varchar(30) not null,
Speciale char default 'N',
foreign key (Leader) references Eroe(Nome)
	on update cascade
	on delete cascade
) ENGINE= InnoDB CHARSET= latin1;
ALTER TABLE Eroe ADD FOREIGN KEY (Squadra) references SquadraAttuale(Nome) on update cascade on delete set null; 

DROP TABLE IF EXISTS SquadraPassata;
create table SquadraPassata (
Nome varchar(30) primary key,
DataScioglimento date,
Leader varchar(30),
foreign key (Leader) references Eroe(Nome)
	on update cascade
	on delete set null
) ENGINE= InnoDB CHARSET= latin1;

DROP TABLE IF EXISTS MembroPassato;
create table MembroPassato (
Squadra varchar(30),
Eroe varchar(30),
primary key(Squadra, Eroe),
foreign key (Squadra) references SquadraPassata(Nome)
	on update cascade
	on delete cascade,
foreign key (Eroe) references Eroe(Nome)
	on update cascade
	on delete cascade
) ENGINE= InnoDB CHARSET= latin1;

DROP TABLE IF EXISTS Boss;
create table Boss (
Codice char(8) primary key,
Stato char default 'V',
foreign key (Codice) references Mostro(Codice)
	on update cascade
	on delete no action
) ENGINE= InnoDB CHARSET= latin1;

DROP TABLE IF EXISTS ArmaUnica;
create table ArmaUnica (
CodiceArma char(8) primary key,
DropBoss char(8) not null,
foreign key (CodiceArma) references Arma(Codice)
	on update cascade
	on delete no action,
foreign key (DropBoss) references Boss(Codice)
	on update cascade
	on delete no action
) ENGINE= InnoDB CHARSET= latin1;


DROP TABLE IF EXISTS Mercante;
create table Mercante (
Nome varchar(30),
LuogoNegozio varchar(30),
Livello smallint default 1,
primary key(Nome, LuogoNegozio),
foreign key (LuogoNegozio) references InsediamentoAbitato(Nome)
	on update cascade
	on delete no action
) ENGINE= InnoDB CHARSET= latin1;

DROP TABLE IF EXISTS InVendita;
create table InVendita (
Mercante varchar(30),
LuogoNegozio varchar(30),
Item char(8),
primary key(Mercante, LuogoNegozio, Item),
foreign key(Mercante, LuogoNegozio) references Mercante(Nome, LuogoNegozio)
	on update cascade
	on delete cascade,
foreign key(Item) references Item(Codice)
	on update cascade
	on delete no action
) ENGINE= InnoDB CHARSET= latin1;

DROP TABLE IF EXISTS Habitat;
create table Habitat (
Mostro char(8),
Localita varchar(30),
primary key(Mostro, Localita),
foreign key (Mostro) references Mostro(Codice)
	on update cascade
	on delete no action,
foreign key (Localita) references LocalitaOstile(Nome)
	on update cascade
	on delete no action
) ENGINE= InnoDB CHARSET= latin1;

DROP TABLE IF EXISTS Inventario;
create table Inventario (
Proprietario varchar(30) primary key,
Capienza int not null,
foreign key(Proprietario) references Eroe(Nome)
	on update cascade
	on delete cascade
) ENGINE= InnoDB CHARSET= latin1;

DROP TABLE IF EXISTS Appartenenza;
create table Appartenenza (
Inventario varchar(30),
Item char(8),
primary key(Inventario, Item),
foreign key (Inventario) references Inventario(Proprietario)
	on update cascade
	on delete cascade,
foreign key (Item) references Item(Codice)
	on update cascade
	on delete no action
) ENGINE= InnoDB CHARSET= latin1;

