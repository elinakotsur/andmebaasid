create database protseduurKOT

use protseduurKOT

--ab hotell
create table guest(
guestID int primary key identity(1,1),
first_name varchar(80),
last_name varchar(80) not null,
member_since date );

select * from guest

insert into guest
values ('elina', 'kotsur', '2026-2-3');

insert into guest
values ('dasa', 'kovalenko', '2024-8-14');

insert into guest
values ('dima', 'pozekov', '2024-8-15');

--protseduur, mis lisab uus guest ja kuvab tabeli
CREATE PROCEDURE lisaGuest
--@parameetrid
@uusNimi varchar(25),
@uusPerenimi varchar(30),
@kuupäev date
AS
BEGIN
--protseduuri sisu
	INSERT INTO guest(first_name, last_name, member_since)
	VALUES (@uusNimi, @uusPerenimi, @kuupäev);
	select * from guest
END

--kutse
EXEC lisaGuest 'Sveta', 'Arabova', '2020-06-03'

--protseduur, mis kustustab guest ig järgi
CREATE PROCEDURE kustutaGuest
@kustutaID int
as
begin
	select * from guest;
	DELETE FROM guest WHERE guestID=@kustutaID;
	select * from guest;
end 

--kutse 
EXEC kustutaGuest 1;

--otsimise esimese tähe järgi
CREATE PROCEDURE otsing1taht
@taht char(1)
as
begin
	select * from guest where first_name LIKE @taht + '%'; --% teised sumbilid
end

--kutse
EXEC otsing1taht 'D'


--lisame uus veerg
ALTER TABLE guest ADD arveSumma money

UPDATE guest set arveSumma = 1000
UPDATE guest set arveSumma = 2000 WHERE guestID=2
UPDATE guest set arveSumma = 1500 WHERE guestID=3


--5. OUTPUT parameetrid (min ja max väärtus)
CREATE PROCEDURE minmaxArve
    @minArve MONEY OUTPUT,
    @maxArve MONEY OUTPUT
AS
BEGIN
    SELECT 
        @minArve = MIN(arveSumma),
        @maxArve = MAX(arveSumma)
    FROM guest;
END;

--kutse
DECLARE @minArve MONEY, @maxArve MONEY;

EXEC minmaxArve @minArve OUTPUT, @maxArve OUTPUT;

PRINT 'Min arv = ' + CONVERT(varchar, @minArve);
PRINT 'Max arv = ' + CONVERT(varchar, @maxArve);


--6. Dünaamiline SQL protseduuris (ALTER TABLE)
--Protseduur veeru lisamiseks või kustutamiseks 
CREATE PROCEDURE muudatus
    @tegevus varchar(10),
    @tabelinimi varchar(25),
    @veerunimi varchar(25),
    @tyyp varchar(25) = NULL
AS
BEGIN
    DECLARE @sqltegevus varchar(max);

    SET @sqltegevus = CASE 
        WHEN @tegevus = 'add' THEN 
            CONCAT('ALTER TABLE ', @tabelinimi, ' ADD ', @veerunimi, ' ', @tyyp)

        WHEN @tegevus = 'drop' THEN 
            CONCAT('ALTER TABLE ', @tabelinimi, ' DROP COLUMN ', @veerunimi)
    END;

    PRINT @sqltegevus;
    EXEC (@sqltegevus);
END;

--kutse 
EXEC muudatus 'add', 'guest', 'testverg', int

EXEC muudatus 'drop', 'guest', 'testverg'



--7. Protseduur, mis kuvab toodete nime, hinna ja lisab automaatselt hinnangu 

CREATE PROCEDURE kuvaArveHinnand
AS
BEGIN
    SELECT 
        first_name,
        arveSumma,
        CASE 
            WHEN arveSumma <= 1000 THEN 'väike summa'
            ELSE 'suur summa'
        END AS hinnang
    FROM guest;
END;

--kutse
EXEC kuvaArveHinnand






















--3. room_type
create table room_type(
room_typeID int primary key identity(1,1),
room_description varchar(80),
max_capacity int);

select * from room_type

insert into room_type
values ('good', 5);

insert into room_type
values ('vip', 10);

insert into room_type
values ('for_millioner', 150);

insert into room_type
values ('for rich', 40);


--1. lisamine 
CREATE PROCEDURE lisaroomType

@uusDescription varchar(80),
@uusCapacity int
AS
BEGIN
--protseduuri sisu
	INSERT INTO room_type(room_description, max_capacity)
	VALUES (@uusDescription, @uusCapacity);
	select * from room_type
END

-- kutse 
EXEC lisaroomType 'premium', '10'


--2. kustutamine
CREATE PROCEDURE kustutatype
@roomTypeID int
as
begin
	select * from room_type;
	DELETE FROM room_type WHERE room_typeID=@roomTypeID;
	select * from room_type;
end 

--kutse 
EXEC kustutatype 1;




--3. otsimine
CREATE PROCEDURE ots1taht
@taht char(1)
as
begin
	select * from room_type where room_description LIKE @taht + '%';
end

--kutse
EXEC ots1taht 'f'





--4. min ja mx arve
ALTER TABLE room_type ADD price money
update room_type set price = 1000
update room_type set price = 900 where room_typeID=4
update room_type set price = 100 where room_typeID=5
update room_type set price = 1870 where room_typeID=2

CREATE PROCEDURE minmaxhind
    @minhind MONEY OUTPUT,
    @maxhind MONEY OUTPUT
AS
BEGIN
    SELECT 
        @minhind = MIN(price),
        @maxhind = MAX(price)
    FROM room_type;
END;

--kutse
DECLARE @minhind MONEY, @maxhind MONEY;

EXEC minmaxhind @minhind OUTPUT, @maxhind OUTPUT;

PRINT 'Min hind = ' + CONVERT(varchar, @minhind);
PRINT 'Max hind = ' + CONVERT(varchar, @maxhind);


--5. veeru lisamine või kustutamine
CREATE PROCEDURE muudatused
    @tegevus varchar(10),
    @tabelinimi varchar(25),
    @veerunimi varchar(25),
    @tyyp varchar(25) = NULL
AS
BEGIN
    DECLARE @sqltegevus varchar(max);

    SET @sqltegevus = CASE 
        WHEN @tegevus = 'add' THEN 
            CONCAT('ALTER TABLE ', @tabelinimi, ' ADD ', @veerunimi, ' ', @tyyp)

        WHEN @tegevus = 'drop' THEN 
            CONCAT('ALTER TABLE ', @tabelinimi, ' DROP COLUMN ', @veerunimi)
    END;

    PRINT @sqltegevus;
    EXEC (@sqltegevus);
END;

EXEC muudatused 'add', 'room_type', 'beds_count', 'int';







--7. Protseduur, mis kuvab toodete nime, hinna ja lisab automaatselt hinnangu 

CREATE PROCEDURE Hinnad
AS
BEGIN
    SELECT 
        room_description,
        price,
        CASE 
            WHEN price <= 900 THEN 'cheap room'
            ELSE 'expencive room'
        END AS hinnang
    FROM room_type;
END;

--kutse
EXEC Hinnad
