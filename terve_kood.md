Create database trigerTITpv24;
use trigerTITpv24;
--
Create table linnad(
linnID int PRIMARY KEY IDENTITY (1,1),
linnanimi varchar(15) NOT NULL,
rahvaarv int);
 --tabel mis täidab triger
Create table logi(
id int PRIMARY KEY IDENTITY (1,1),
kasutaja varchar(25),
aeg DATETIME,
toiming  varchar(100),
andmed TEXT --triger automaatselst lisab mida sekretaar lisas/kustutas tabelisse linnad
)

select * from linnad;
select * from logi;

--Jälgib andmete sisestamine tabelis linnad ja teeb vastava kirje tabelis logi

CREATE TRIGGER linnaLisamine
ON linnad --tabelinimi, mis on vaja jälgida
FOR INSERT
AS
INSERT INTO logi(kasutaja, aeg, toiming, andmed)
SELECT
SYSTEM_USER,
GETDATE(),  --aeg
'on tehtud INSERT käsk',  --toiming
inserted.linnanimi  --andmed
FROM inserted;


--kontrollimiseks insert into linnad 
INSERT INTO linnad(linnanimi, rahvaarv)
VALUES ('Tallinn', 600000);

INSERT INTO linnad(linnanimi, rahvaarv)
VALUES ('Tartu', 250000);

INSERT INTO linnad(linnanimi, rahvaarv)
VALUES ('Viimsi', 2500);

SELECT * FROM linnad;
SELECT * FROM logi;

--triggerimuutmine
ALTER TRIGGER linnaLisamine
ON linnad --tabelinimi, mis on vaja jälgida
FOR INSERT
AS
INSERT INTO logi(kasutaja, aeg, toiming, andmed)
SELECT
SYSTEM_USER,
GETDATE(),  --aeg
'on tehtud INSERT käsk',  --toiming
CONCAT('linn: ', inserted.linnanimi , ', rahvaarv: ', inserted.rahvaarv) --andmed
FROM inserted;




CREATE TRIGGER kustutamine
ON linnad --tabelinimi, mis on vaja jälgida
FOR DelEte
AS
INSERT INTO logi(kasutaja, aeg, toiming, andmed)
SELECT
SYSTEM_USER,
GETDATE(),  --aeg
'on tehtud DELETE käsk',  --toiming
CONCAT('linn: ', deleted.linnanimi , ', rahvaarv: ', deleted.rahvaarv) --andmed
FROM deleted;

--kontroll kustutamine
DELETE from linnad where linnID=1;

SELECT * FROM linnad;
SELECT * FROM logi;






--update triger
CREATE TRIGGER linnaUUendamine
ON linnad --tabelinimi, mis on vaja jälgida
FOR UPDATE
AS
INSERT INTO logi(kasutaja, aeg, toiming, andmed)
SELECT
SYSTEM_USER,
GETDATE(),  --aeg
'on tehtud UPDATE käsk',  --toiming
CONCAT('VANAD: linn: ', deleted.linnanimi , ', rahvaarv: ', deleted.rahvaarv,
'||| UUED: linn: ', inserted.linnanimi , ', rahvaarv: ', inserted.rahvaarv) --andmed
FROM deleted INNER JOIN inserted
on deleted.linnID=inserted.linnID;

--kontroll uuendamine

update linnad set linnanimi='Narva-väike', rahvaarv=50 where linnID=2

SELECT * FROM linnad;
SELECT * FROM logi;



disable trigger linnaLisamine on linnad;
disable trigger kustutamine on linnad;








--kombineerimine
CREATE TRIGGER LinnaLisajaKustutamine
ON linnad --tabelinimi, mis on vaja jälgida
FOR DelEte
AS
BEGIN
	INSERT INTO logi(kasutaja, aeg, toiming, andmed)
	SELECT
	SYSTEM_USER,
	GETDATE(),  --aeg
	'on tehtud DELETE käsk',  --toiming
	CONCAT('linn: ', deleted.linnanimi , ', rahvaarv: ', deleted.rahvaarv) --andmed
	FROM deleted

	UNION ALL

	SELECT
	SYSTEM_USER,
	GETDATE(),  --aeg
	'on tehtud INSERT käsk',  --toiming
	inserted.linnanimi  --andmed
	FROM inserted;
END;






--kontroll 
INSERT INTO linnad(linnanimi, rahvaarv)
VALUES ('Tallinn', 650000);
DELETE from linnad where linnID=3;

SELECT * FROM linnad;
SELECT * FROM logi;




--kasutaja sekretarElina õigused - lisamine, kustutamine ja uuendamine tabelis linnad 
--ei näe tabeli logi ja ei saa muuta triggerid

grant select, insert, update, delete on linnad to sekuritiElina;
deny select on logi to sekuritiElina;

deny alter any database DDL TRIGGER to sekuritiElina

