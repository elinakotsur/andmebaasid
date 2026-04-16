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
  ```
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
```

```
