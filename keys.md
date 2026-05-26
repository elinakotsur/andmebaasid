# KEYS

- ## Primary Key

Definitsioon: Primary Key on tabeli peamine võti, mis identifitseerib iga rea unikaalselt.

Milleks kasutatakse: Seda kasutatakse selleks, et tabelis ei oleks kahte одинаковых rida sama ID-ga.

Erinevus teistest võtmetest: Primary Key peab olema alati unikaalne ja ei tohi sisaldada NULL väärtust.

Kood:
```sql
CREATE TABLE Opilased (
    opilane_id INT PRIMARY KEY,
    nimi VARCHAR(50)
);
```
Ekraanipilt:

<img width="272" height="198" alt="{0683997C-B5C8-4425-9DC8-8A2CA878770A}" src="https://github.com/user-attachments/assets/fea440bd-72a3-4d00-bb75-b72eeeb61d88" />

- ## Foreign Key

Definitsioon: Foreign Key on väli, mis ühendab kaks tabelit omavahel.

Milleks kasutatakse: Sellega luuakse seos tabelite vahel.

Erinevus teistest võtmetest: Foreign Key viitab teise tabeli Primary Key väärtusele.

Kood:
```sql
CREATE TABLE Opilased (
    opilane_id INT PRIMARY KEY,
    nimi VARCHAR(50)
);

CREATE TABLE Registreerimine (
    reg_id INT PRIMARY KEY,
    opilane_id INT,
    FOREIGN KEY (opilane_id) REFERENCES Opilased(opilane_id)
);
```
Ekraanipilt:

<img width="593" height="141" alt="{D4573032-6956-4060-B962-67381776B71A}" src="https://github.com/user-attachments/assets/28c569a2-de48-4b4f-9328-c63b09d1d084" />

- ## Unique Key

Definitsioon: Unique Key tagab, et kõik väärtused veerus on erinevad.

Milleks kasutatakse: Et vältida korduvaid väärtusi.

Erinevus teistest võtmetest: Võib sisaldada ühte NULL väärtust, Primary Key ei või.

Kood:
```sql
CREATE TABLE Kasutajad (
    kasutaja_id INT PRIMARY KEY,
    email VARCHAR(100) UNIQUE
);
```
Ekraanipilt:

<img width="309" height="208" alt="{0E0E690B-3E23-4312-8036-914B8AE3F390}" src="https://github.com/user-attachments/assets/4f0645ac-4e07-443e-9567-22b44382a8af" />

- ## Simple Key

Definitsioon: Simple Key koosneb ainult ühest veerust.

Milleks kasutatakse: Ühe väljaga rea leidmiseks.

Erinevus teistest võtmetest: Ei kasuta mitut veergu.

Kood:
```sql
CREATE TABLE Opilased (
    opilane_id INT PRIMARY KEY,
    nimi VARCHAR(50) --simple key
);
```

Ekraanipilt:

<img width="338" height="164" alt="{6B0A10B9-C4DF-4EA7-827A-056B3444DAD0}" src="https://github.com/user-attachments/assets/a863c761-6d6c-49af-b6b5-29fa5b5b37da" />

- ## Composite Key

Definitsioon: Composite Key koosneb kahest või enamast veerust.

Milleks kasutatakse: Kui üks veerg ei ole piisavalt unikaalne.

Erinevus teistest võtmetest: Unikaalsus tekib mitme välja kombinatsioonist.

Kood:
```sql
CREATE TABLE Hinded (
    opilane_id INT,
    aine_id INT,
    hinne INT,
    PRIMARY KEY (opilane_id, aine_id)
);
```

Ekraanipilt:

<img width="358" height="242" alt="{FC157605-CC85-49B7-95B6-779BB12800A5}" src="https://github.com/user-attachments/assets/0e863ec3-1404-4825-bf73-be2cb67477be" />

- ## Compound Key

Definitsioon: Compound Key on Composite Key liik, kus võtmes võivad olla ka Foreign Key väljad.

Milleks kasutatakse: Mitme tabeli andmete ühendamiseks.

Erinevus teistest võtmetest: Sisaldab tavaliselt vähemalt ühte Foreign Key välja.

Kood:
```sql
CREATE TABLE Tellimused (
    klient_id INT,
    toode_id INT,
    kogus INT,
    PRIMARY KEY (klient_id, toode_id)
);
```

Ekraanipilt:

<img width="350" height="225" alt="{5AF6F6B1-BA85-45DC-9FF1-556E1B33D1BD}" src="https://github.com/user-attachments/assets/d19790c8-f27f-4ba0-aa59-713ffa079828" />


- ## Superkey

Definitsioon: Superkey on üks või mitu välja, mis identifitseerivad rea unikaalselt.

Milleks kasutatakse: Ridade eristamiseks tabelis.

Erinevus teistest võtmetest: Võib sisaldada lisavälju rohkem kui vaja.

Kood:
```sql
CREATE TABLE TooTajad (
    tootaja_id INT,
    isikukood VARCHAR(11),
    email VARCHAR(100),
    UNIQUE (tootaja_id, email)
);
```

Ekraanipilt:

<img width="284" height="198" alt="{667A143A-02A6-46CC-822A-90F5605D8D49}" src="https://github.com/user-attachments/assets/f0aafd1b-facb-4b41-a380-83ca44455a8d" />

- Candidate Key



- Alternate Key


https://www.w3schools.com/sql/sql_primarykey.asp?utm_source=chatgpt.com
