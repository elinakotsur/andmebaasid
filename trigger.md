## Trigger - triger - päästik
- andmebaasi objekt mis automatselt käivitud tabeli sündmused (INSER, UPDATE, DELETE)

```sql
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


SELECT * FROM linnad;
SELECT * FROM logi;

--riggerimuutmine
ALTER TRIGGER linnaLisamine
ON linnad --tabelinimi, mis on vaja jälgida
FOR INSERT
AS
INSERT INTO logi(kasutaja, aeg, toiming, andmed)
SELECT
SYSTEM_USER,
GETDATE(),  --aeg
'on tehtud INSERT käsk',  --toiming
CONCAT('linn: ', inserted.linnanimi , 'rahvaarv: ', inserted.rahvaarv) --andmed
FROM inserted;
```

<img width="585" height="439" alt="{36693FAE-8A98-4D07-88F8-D01CF185065C}" src="https://github.com/user-attachments/assets/a6e8de56-20e7-4b6e-ad85-e7f267cc4cfb" />
