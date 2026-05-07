## sql Protseduurid
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
```sql
--kutse
EXEC lisaGuest 'Sveta', 'Arabova', '2020-06-03'
```
<img width="393" height="199" alt="{3236F381-684D-4B8A-B272-A54C593F8162}" src="https://github.com/user-attachments/assets/8558a0c1-0715-40ae-b884-55bc79883caf" />


