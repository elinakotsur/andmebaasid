# Andmebaasid
andmebaaside seotud SQL kood ja konspektid
## Põhimõisted
- andmebaas - struktureeritud andmete kogum
- tabel = olem - сущность
- veerg = väli -столбец
- ruda =kirje - запись
- andmebaasi haldussüsteem - tarkvara, millega abi saab luua andmebaas: mariaDB / XAMPP, SQL SERVER managment Studio.
  <img width="483" height="519" alt="{52C16002-2387-41E5-A896-A30933EA7F8C}" src="https://github.com/user-attachments/assets/d8859abc-78da-4f09-937c-a8007a7c07d1" />

- primaarne võti -PRIMARY KEY - veerg(tavaliselt id nimega), unikaalne identifikaator mis eristab iga kirje.
- välisvõti - FOREIGN KEY - FK - veerg, mis loob seos teise tabeli primaarvõtmega.
- päring -QUERY - запрос 

## Andmetüübiid
```
1. Numbrelised: INT, SmallINT, float, decimal(5,2)
2. Tekst/Sümboolised: varchar(255), char(5), TEXT
3. Loogilised: boolen, true/false, bit, bool
4. Kuupäeva: date, time, datetime
```
## SQL - strktuure Query Language - struktuureeritud päringu keel
- Tabeli loomine
```sql
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
```
- Andmete sisestamine tabelisse
```sql
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
```
## Seosed (tabelivahelised seosed)
- üks-ühele (nt mees-naine)
- üks-mitmele (nt ema-lapsed)
<img width="544" height="368" alt="{E342D6FD-FB11-4E0D-BCB3-2715C70B3FFA}" src="https://github.com/user-attachments/assets/a8a6c448-fc70-43f4-8abb-c99490e1d8af" />

  
- mitu-mitele (nt õpilased - õpetajad)


## PIIRANGUD 
constraint- ограничения (5)

- PRIMARY KEY
- FOREIGN KEY
- CHECK
- NOT NULL
- UNIQUE



```sql
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


```

## ALTER TABLE
- tabeli struktuuri muutmine (struktuur: veerudenimed, andmetüübid,piirangud)
1. uue veeru lisamine

```sql
--uue veeru lisamine
ALTER TABLE opilane ADD isikukood varchar(11);
--veeru kustutamine
ALTER TABLE opilane DROP COLUMN isikukood;
--andmetüübi muutmine varchar(11)--char(11)
ALTER TABLE opilane ALTER COLUMN isikukood char(11);
--sisseehitatud protsedur miss näitab tabeli
sp_help opilane;
```
