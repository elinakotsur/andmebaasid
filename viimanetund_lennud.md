```sql
create database Arvestutöö
use Arvestutöö

create table Lennujaam(
LennujaamID int primary key identity(1,1),
LennujaamNimi varchar(50),
Linn varchar(20))


INSERT INTO Lennujaam 
VALUES ('Tallinna Lennujaam', 'Tallinn'),
('Riga Airport', 'Riga'),
('Helsinki-Vantaa', 'Helsinki')


select * from Lennujaam
create table Lend(
LendID int primary key identity(1,1),
LennuNimber int,
Väljamuseaeg date,
LennujaamID int
foreign key (LennujaamID) references Lennujaam(LennujaamID));

INSERT INTO Lend 
VALUES (101, '2026-06-15', 1), 
(202, '2026-06-16', 2),
(303, '2026-06-17', 3)


INSERT INTO Lend 
VALUES (106, '2026-06-19', 1)

create table Reisja(
ReisjaID int primary key identity(1,1),
Nimi varchar(20),
PiletiNumber int,
LendID int
foreign key (LendID) references Lend(LendID))

INSERT INTO Reisja 
VALUES ('Elina', 5, 3), 
('Nastja', 89, 3), 
('Dasa', 11, 2)

SELECT * from Reisja 



GRANT CREATE TABLE TO reisjaElina;
GRANT SELECT TO reisjaElina;
GRANT INSERT, DELETE ON Lend TO reisjaElina;
GRANT INSERT, DELETE ON Reisja TO reisjaElina;
DENY SELECT ON logi TO reisjaElina;

Create table logi(
id int PRIMARY KEY IDENTITY (1,1),
kasutaja varchar(25),
kuupaev DATETIME,
sisestatudAndmed TEXT
)

ALTER TRIGGER lend_Kustutamine
ON Lend 
FOR DELETE
AS
BEGIN
INSERT INTO logi (kasutaja, kuupaev, sisestatudAndmed)
SELECT
SYSTEM_USER, 
GETDATE(),  
CONCAT('KUSTUTATUD LEND ID: ', deleted.LendID, ', Number: ', deleted.LennuNimber, ', Aeg: ', deleted.Väljamuseaeg,  ' ', Lennujaam.LennujaamNimi)
FROM deleted join Lennujaam on Lennujaam.LennujaamID=deleted.LennujaamID;
END;

SELECT * FROM Lend;
SELECT * FROM logi;








Alter TRIGGER lend_Lisamine
ON Lend 
FOR INSERT
AS
BEGIN
INSERT INTO logi (kasutaja, kuupaev, sisestatudAndmed)
SELECT
SYSTEM_USER, 
GETDATE(),  
CONCAT('LISATUD LEND ID: ', inserted.LendID, ', Number: ', inserted.LennuNimber, ', Aeg: ', inserted.Väljamuseaeg, ' ', Lennujaam.LennujaamNimi)
FROM inserted join Lennujaam on Lennujaam.LennujaamID=inserted.LennujaamID;
END;

SELECT * FROM Lend;
SELECT * FROM logi;


---protsedur1
CREATE PROCEDURE lisaLend
@lennuNumber INT,
@valjumisaeg DATE,
@lennujaamID INT
AS
BEGIN
INSERT INTO Lend (LennuNimber, Väljamuseaeg, LennujaamID)
VALUES (@lennuNumber, @valjumisaeg, @lennujaamID);
SELECT * FROM Lend;
END;

EXEC lisaLend 404, '2026-06-25', 1;


---protsedur2
CREATE PROCEDURE kustutaReisja
@kustutaID INT
AS
BEGIN
SELECT * FROM Reisja;
DELETE FROM Reisja WHERE ReisjaID = @kustutaID;
SELECT * FROM Reisja;
END;

EXEC kustutaReisja 3;

---protsedur3
CREATE PROCEDURE otsingReisja1taht
@taht CHAR(1)
AS
BEGIN
SELECT * FROM Reisja WHERE Nimi LIKE @taht + '%';
END;

EXEC otsingReisja1taht 'E';


create table Kohad (
KohaID INT PRIMARY KEY IDENTITY(1,1),
IsteKoht VARCHAR(10),       
Klass VARCHAR(20),         
ReisjaID int
foreign key (ReisjaID) references Reisja(ReisjaID)
)
INSERT INTO Kohad 
VALUES ('1A', 'Business', 4),
('12B', 'Economy', 2)




CREATE VIEW vaade_ReisijadLend3 AS
SELECT Reisja.Nimi, Reisja.PiletiNumber, Lend.LennuNimber
FROM Reisja
JOIN Lend ON Reisja.LendID = Lend.LendID
WHERE Lend.LendID = 3;

SELECT * FROM vaade_ReisijadLend3;




CREATE VIEW vaade_LennudHelsinki AS
SELECT Lend.LennuNimber, Lend.Väljamuseaeg, Lennujaam.Linn
FROM Lend
JOIN Lennujaam ON Lend.LennujaamID = Lennujaam.LennujaamID
WHERE Lennujaam.Linn = 'Helsinki';

SELECT * FROM vaade_LennudHelsinki;










create VIEW vaade_KoikKokku AS
SELECT Nimi AS Objekt, PiletiNumber AS ID, 'Reisija (LendID=3)' AS Info
FROM Reisja
WHERE LendID = 3

UNION ALL

SELECT LennujaamNimi, LennujaamID, 'Lennujaam (Tallinn)'
FROM Lennujaam
WHERE Linn = 'Tallinn';

SELECT * FROM vaade_KoikKokku



SELECT * FROM Lennujaam;
SELECT * FROM Lend;
SELECT *WHERE Lennujaam.Linn = 'Helsinki'; FROM Reisja;
```
