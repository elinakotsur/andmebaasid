CREATE Database KOTSURbaas;
Use KOTSURbaas;

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

INSERT INTO opilane
VALUES ('Elina','Kotsur','2008-5-3',1,'+364785','Tallin', 4.5)

INSERT INTO opilane(perenimi, eesnimi, keskmineHinne)
VALUES ('Kovalenko','Dasa', 4.2),
('Pozekov','Dima', 4.6),
('Järvine',' Mihael', 3.6);




UPDATE opilane SET stip=1, aadress='Tallinn';

UPDATE opilane SET stip=1, aadress='Tartu' WHERE opilaneID=4;



--uue veeru lisamine
ALTER TABLE opilane ADD isikukood varchar(11);
--veeru kustutamine
ALTER TABLE opilane DROP COLUMN isikukood;
--andmetüübi muutmine varchar(11)--char(11)
ALTER TABLE opilane ALTER COLUMN isikukood char(11);
--sisseehitatud protsedur miss näitab tabeli
sp_help opilane;





--piirangute lisamine
CREATE TABLE ryhm(
ryhmID int NOT NULL,
ryhmnimi char(10))

--PK lisamine
ALTER TABLE ryhm ADD CONSTRAINT pk_ryhm PRIMARY KEY (ryhmID);
--UNIQUE lisamine
ALTER TABLE ryhm ADD CONSTRAINT un_ryhm UNIQUE (ryhmnimi);

--kontrollimiseks täidame tabelit
SELECT * FROM ryhm
INSERT INTO ryhm (ryhmID, ryhmnimi)
--VALUES (1, 'TITpv24');
--VALUES (2, 'TITpe24');
VALUES (3, 'TITpv23');


--lsamine Foreign KEY - võõrvõti-välisvõti
ALTER TABLE opilane ADD ryhmID int;

ALTER TABLE opilane ADD CONSTRAINT fk_ryhm
FOREIGN KEY (ryhmID) REFERENCES ryhm(ryhmID);
--kontrollimiseks- täidame tabeli opilane
INSERT INTO opilane
VALUES ('Ksusa','Kartasova','2008-5-10',1,'+364785','Tallin', 4.5, '12124', 2);



SELECT * FROM opilane;
SELECT * FROM ryhm;
