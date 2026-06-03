## sql Protseduurid

[põhimõisted](README.md) | [hotelliruumide loomine](hotelliruum.md) | [kasutajade loomine](kasutaja.md) | [kasutajade loomineXAMPPis](xamppkasutajad.md) | [küsimusedSQL](kysimused.md) | [trigerid](trigger.md) | [protseduurid SQL Serveris](protseduur.md) | [protseduurid XAMPPis](protseduurxampp.md) | [keys kodutöö](keys.md)

- store protsedure - salvestatud protseduurid - хранимые процедуры
- sama nagu funktsiooni programeerimises - mingid tegevused, mis käivitakse protseduuri kasutamisel
```sql

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
```

<img width="257" height="275" alt="{E824B51B-653F-4066-9FE3-408A390A0F3D}" src="https://github.com/user-attachments/assets/8b5865f3-baf4-406d-828a-4b6e368672dc" />

- guest lisamine
```sql

--kutse
EXEC lisaGuest 'Sveta', 'Arabova', '2020-06-03'

```

<img width="393" height="199" alt="{3236F381-684D-4B8A-B272-A54C593F8162}" src="https://github.com/user-attachments/assets/8558a0c1-0715-40ae-b884-55bc79883caf" />

- guest kustutamine
```sql
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
```
<img width="358" height="433" alt="{C3024984-44A8-4005-A925-CFE6808A45F0}" src="https://github.com/user-attachments/assets/50d7c504-e968-4fd3-b722-d5e6c77b7352" />

- guest otsimine

```sql
--otsimise esimese tähe järgi
CREATE PROCEDURE otsing1taht
@taht char(1)
as
begin
	select * from guest where first_name LIKE @taht + '%'; --% teised sumbilid
end

--kutse
EXEC otsing1taht 'D'
```
<img width="557" height="264" alt="{B5FBB6EF-CF9C-4960-9F62-646A33753070}" src="https://github.com/user-attachments/assets/c3ba1129-c249-4e6a-b08b-3968666be752" />

- guest min ja mx arve

```sql
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
```
<img width="421" height="496" alt="{E445096D-5BBC-41C1-B34B-14E1EA86324D}" src="https://github.com/user-attachments/assets/b7470908-cf7d-4a85-be3d-6b9749e3cbf8" />

- veeru lisamine või kustutamine

```sql
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
```
<img width="559" height="509" alt="{FCA3B06B-6E1E-4175-BDDC-01F5A968F8F1}" src="https://github.com/user-attachments/assets/46b4aa75-0630-4a78-af32-a83ac68990bf" />

-

```sql
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
```
<img width="544" height="440" alt="{4DFBDD45-EC81-47AC-92E6-5632DDBB0328}" src="https://github.com/user-attachments/assets/290041e1-74f2-4a90-94f5-943a1fa00a6f" />


