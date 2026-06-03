## Trigger - triger - päästik
- andmebaasi objekt mis automatselt käivitud tabeli sündmused (INSER, UPDATE, DELETE)
### lisamise trigger 
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

INSERT INTO linnad(linnanimi, rahvaarv)
VALUES ('Viimsi', 2500);

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
CONCAT('linn: ', inserted.linnanimi , ', rahvaarv: ', inserted.rahvaarv) --andmed
FROM inserted;
```

<img width="621" height="331" alt="{6B66A5CB-7062-4D51-B408-A17811569EC9}" src="https://github.com/user-attachments/assets/f42302ba-c324-4251-b593-406069bbf2f9" />

### kustutamise triger

```sql
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
```

<img width="683" height="210" alt="{02395B8F-8110-442F-8766-43112642B3E2}" src="https://github.com/user-attachments/assets/6f656c2b-9ff2-44b7-bc72-4a73f52edac1" />

 ### triger update 

 ```sql
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
 ```

<img width="941" height="246" alt="{51FDB3A2-E975-4F8C-9420-D4BFF56E009B}" src="https://github.com/user-attachments/assets/f6f1d990-ef1d-46c1-bb3e-c7ad86e5bff8" />


