CREATE DATABASE KOTSURbaas;
--ab kustutamine
DROP DATABASE Robert
use KOTSURbaas;
--tabeli loomine
CREATE TABLE opilane(
opilaneID int Primary Key identity(1,1), --automaatselt täitab numbritega
eesnimi varchar(25),
perenimi varchar(30) NOT NULL,
synniaeg DATE, 
stip bit,
mobiil varchar(13),
aadress TEXT,
keskmineHinne decimal(2,1) );--(2--kokku, 1 peale komat nt 4.5)

SELECT * FROM opilane;

--tabeli täitmine
INSERT INTO opilane
VALUES ('Elina','Kotsur','2008-5-3',1,'+364785','Tallin', 4.5)

INSERT INTO opilane(perenimi, eesnimi, keskmineHinne)
VALUES ('Kovalenko','Dasa', 4.2),
('Pozekov','Dima', 4.6),
('Järvine',' Mihael', 3.6);

UPDATE opilane SET stip=1, aadress='Tallinn';

UPDATE opilane SET stip=1, aadress='Tartu' WHERE opilaneID=4;

--kustutamine 
--tabeli kustustamine
DROP TABLE opilane;

--andmete kustutamine tabelis
DELETE FROM opilane WHERE opilaneID=1;
Select * from opilane;


--FOREIGN KEY
CREATE TABLE opitamine(
opitamineID int Primary Key identity(1,1),
kuupaev DATE,
opitamine varchar(30),
opilaneID int, 
FOREIGN KEY (opilaneID) REFERENCES opilane(opilaneID),
hinne int CHECK(hinne<=5));

Select * FROM opitamine;
Select * from opilane;

--täidamine tabeli
INSERT INTO opitamine
--VALUES ('2026-4-16', 'andmebaasid', 2, 5)
VALUES ('2026-4-16', 'andmebaasid', 5, 5)








--opetaja TABLE
CREATE TABLE opetaja(
opetajaID int PRIMARY KEY identity(1,1),
nimi varchar(35),
epost varchar(20),
ruum varchar(5));

Select * FROM opetaja;


--täidmine
INSERT INTO opetaja
VALUES('Lehtla', 'lehtla@gmail', 'A123');



--tund TABLE
CREATE TABLE tund(
tundID int PRIMARY KEY identity(1,1),
kuupaev DATE,
tundNimi varchar(20),
opetajaID int,
FOREIGN KEY (opetajaID) REFERENCES opetaja(opetajaID),
opitamineID int,
FOREIGN KEY (opitamineID) REFERENCES opitamine(opitamineID));

Select * FROM tund;

INSERT INTO tund
VALUES('2026-12-3', 'arvutivorgud', '1','2');


 

Select * FROM opitamine;
Select * from opilane;
Select * FROM tund;
Select * FROM opetaja;
