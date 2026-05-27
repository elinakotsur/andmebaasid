```sql
create database RetseptiRaamat
use RetseptiRaamat
--kasutaja
create table kasutaja(
kasutaja_id int primary key identity(1,1),
eesnimi varchar(50),
perenim varchar(50),
email varchar(150) );

INSERT INTO kasutaja 
VALUES ('Elina', 'kotsur', 'elina@gmail.com'),
('Dasa', 'Koval', 'dasa.p@hotmail.com'),
('Savelij', 'Mart', 'sava.tamm@mail.ee'),
('Nastja', 'Jush', 'nastja.kask@gmail.com'),
('Elena', 'Mjakiseva', 'elena.sm@yahoo.com');


--kategooria
create table kategooria(
kategooria_id int primary key identity(1,1),
kategooria_nimi varchar(50) );

INSERT INTO kategooria 
VALUES ('Liha'),
('India köök'),
('Koogid'),
('Salatid'),
('Hommikusöögid');


--toiduaine
create table toiduaine(
toiduaine_id int primary key identity(1,1),
toiduaine_nimi varchar(100) );

INSERT INTO toiduaine 
VALUES ('Kartul'),
('Piim'),
('Kanaliha'),
('Suhkur'),
('Nisujahu');


--yhik
create table yhik(
yhik_id int primary key identity(1,1),
yhik_nimi varchar(100) );

INSERT INTO yhik 
VALUES ('g'),
('kg'),
('ml'),
('l'),
('tk');

select * from yhik
--respts
create table retsept(
retsept_id int primary key identity(1,1),
retsept_nimi varchar(100),
kirjeldus varchar(200),
juhend varchar(500),
sisestatud_kp date,
kasutaja_id int
FOREIGN KEY (kasutaja_id) REFERENCES kasutaja(kasutaja_id),
kategooria_id int
FOREIGN KEY (kategooria_id) REFERENCES kategooria(kategooria_id) );

INSERT INTO retsept 
VALUES ('Praetud kana', 'Mahlane praetud kanaliha', 'Tükelda kana, maitsesta ja prae pannil kuldpruuniks.', '2026-01-15', 1, 1), 
('Chicken Tikka Masala', 'Vürtsikas India kana koorekastmes', 'Küpseta kana vürtsidega ja lisa koorekaste.', '2026-05-12', 5, 2), 
('Šokolaadikook', 'Mahlane šokolaadikook', 'Sulata šokolaad, sega jahu ja suhkruga, küpseta.', '2026-04-05', 4, 3), 
('Kartulisalat', 'Traditsiooniline pidupäeva salat', 'Keeda kartul, tükelda koostisosad ja sega hapukoorega.', '2026-03-10', 3, 4), 
('Pannkoogid', 'Õhulised ja magusad pannkoogid', 'Sega piim, jahu, muna ja suhkur. Prae pannil.', '2026-02-20', 2, 5); 


--koostis
create table koostis(
koostis_id int primary key identity(1,1),
kogus int,
retsept_retsept_id int
FOREIGN KEY (retsept_retsept_id) REFERENCES retsept(retsept_id),
toiduaine_id int
FOREIGN KEY (toiduaine_id) REFERENCES toiduaine(toiduaine_id),
yhik_id int
FOREIGN KEY (yhik_id) REFERENCES yhik(yhik_id) );


INSERT INTO koostis
VALUES (500, 1, 3, 1),
(500, 2, 3, 1),
(50, 3, 4, 1), 
(3, 4, 1, 5),  
(200, 5, 5, 1);


--hinnad
CREATE TABLE hind (
hind_id INT PRIMARY KEY IDENTITY(1,1),
hind_eur DECIMAL(6,2),  
retsept_id INT
FOREIGN KEY (retsept_id) REFERENCES retsept(retsept_id)
);

INSERT INTO hind 
VALUES (8.50, 1),  
(12.90, 2),
(15.00, 3), 
(5.20, 4),  
(4.50, 5);




create table tehtud(
tehtud_id int primary key identity(1,1),
tehtud_kp date,
retsept_id int
FOREIGN KEY (retsept_id) REFERENCES retsept(retsept_id) );

INSERT INTO koostis
VALUES (500, 1, 3, 1),
(500, 2, 3, 1),
(50, 3, 4, 1), 
(3, 4, 1, 5),
(200, 5, 5, 1);


SELECT * FROM kasutaja;
SELECT * FROM kategooria;
SELECT * FROM toiduaine;
SELECT * FROM yhik;
SELECT * FROM retsept;
SELECT * FROM koostis;
SELECT * FROM tehtud;



--uus retsepti lisamine
CREATE PROCEDURE lisa_retsept
    @nimi VARCHAR(100),
    @kirj VARCHAR(200),
    @juh VARCHAR(500),
    @kp DATE,
    @kasutaja INT,
    @kategooria INT
AS
BEGIN
    INSERT INTO retsept
    (retsept_nimi, kirjeldus, juhend, sisestatud_kp, kasutaja_id, kategooria_id)
    VALUES
    (@nimi, @kirj, @juh, @kp, @kasutaja, @kategooria);
END;

EXEC lisa_retsept 'maasika kook', 'lihtne maasika kook', 'maasika moosiga kook', '2024-12-07', 1, 3;



--muuda tabeli nimi
CREATE PROCEDURE muuda_tabeli_nimi
@vana_nimi VARCHAR(128),
@uus_nimi VARCHAR(128)
AS
BEGIN
EXEC sp_rename @vana_nimi, @uus_nimi;
END;

EXEC muuda_tabeli_nimi 'tehtud', 'tehtud1';



--otsimine kasutajat
CREATE PROCEDURE otsing1taht
@taht char(1)
as
begin
	select * from kasutaja where eesnimi LIKE @taht + '%'; 
end


EXEC otsing1taht 'E'


--veergi lisamine
CREATE PROCEDURE lisaVeerg
@tabel varchar(50),
@veeruNimi varchar(50),
@tyyp varchar(50)
AS
BEGIN
DECLARE @sql varchar(200);
SET @sql = 'ALTER TABLE ' + @tabel + ' ADD ' + @veeruNimi + ' ' + @tyyp;
EXEC(@sql);
SELECT name FROM sys.columns WHERE object_id = OBJECT_ID(@tabel);
END

EXEC lisaVeerg 'kasutaja', 'number', 'varchar(20)';


--5. minmax hind
CREATE PROCEDURE minmaxHind
    @minHind MONEY OUTPUT,
    @maxHind MONEY OUTPUT
AS
BEGIN
    SELECT 
        @minHind = MIN(hind_eur),
        @maxHind = MAX(hind_eur)
    FROM hind;
END;

DECLARE @minHind MONEY, @maxHind MONEY;
EXEC minmaxHind @minHind OUTPUT, @maxHind OUTPUT;
PRINT 'Min arv = ' + CONVERT(varchar, @minHind);
PRINT 'Max arv = ' + CONVERT(varchar, @maxHind);



--õigused

GRANT SELECT, INSERT ON toiduaine TO staffTITpv24;
GRANT SELECT, INSERT ON kategooria TO staffTITpv24;
GRANT SELECT ON kasutaja TO staffTITpv24;
DENY UPDATE, DELETE ON toiduaine TO staffTITpv24;
DENY UPDATE, DELETE ON kategooria TO staffTITpv24;



GRANT SELECT ON kasutaja TO managerTITpv24;
GRANT SELECT ON kategooria TO managerTITpv24;
GRANT SELECT ON toiduaine TO managerTITpv24;
GRANT SELECT ON yhik TO managerTITpv24;
GRANT SELECT ON retsept TO managerTITpv24;
GRANT SELECT ON koostis TO managerTITpv24;
GRANT SELECT ON tehtud1 TO managerTITpv24;
GRANT INSERT, UPDATE, DELETE ON retsept TO managerTITpv24;
GRANT INSERT, UPDATE, DELETE ON koostis TO managerTITpv24;
DENY INSERT ON toiduaine TO managerTITpv24;
DENY INSERT ON kasutaja TO managerTITpv24;
```
