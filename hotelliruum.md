## Andmebaas hotelliruumi reserverimine
### Table
```sql
create Database hotellKOTSURbaas;
use hotellKOTSURbaas;
```
- guest
```sql
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
```
<img width="315" height="121" alt="{C1853BE5-0C5E-4810-8589-83A022BD7BA3}" src="https://github.com/user-attachments/assets/64765c1b-c765-4732-87ac-9bddc884bfa3" />

- reservation
```sql
--2. reservation

create table reservation(
reservationID int primary key identity(1,1),
date_in DATE,
date_out date,
made_by varchar(20),
guestID int,
foreign key (guestID) references guest(guestID));

select * from reservation

insert into reservation
values ('2025-3-4', '2025-7-4', 'admin', 1);

insert into reservation
values ('2023-6-4', '2025-7-4', 'admin1', 2);

insert into reservation
values ('2024-12-5', '2024-12-6', 'admin2', 3);
```
<img width="385" height="116" alt="{06878E83-E0AD-411F-8931-9D9526E6BA17}" src="https://github.com/user-attachments/assets/6c7f0320-8c79-49cc-8306-12a25b9a4f29" />

- room_type
```sql
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
```
<img width="310" height="84" alt="{C1532AEE-68D4-4128-8388-696959FCAEC5}" src="https://github.com/user-attachments/assets/6c68d459-52ac-417e-8497-733c16a495f0" />

- room
```sql
--4. room

create table room(
roomID int primary key identity(1,1),
number varchar(10),
room_name varchar(40),
room_status varchar(10),
smoke bit,
room_typeID int,
foreign key (room_typeID) references room_type(room_typeID));

select * from room;

insert into room
values ('A123', 'good_room1', 'vaba', 0, 1)

insert into room
values ('B113', 'super_room', 'vaba', 1, 2)

insert into room
values ('B333', 'premium_room', 'vaba', 1, 3)
```
<img width="419" height="102" alt="{549A8D1D-A95F-4946-A077-0E3D168A4691}" src="https://github.com/user-attachments/assets/3191e3ef-4bac-4e7a-b4c9-2ecb557aa5ae" />
- reserved_room
```sql
--5. reserved_room

create table reserved_room(
reserved_roomID int primary key identity(1,1),
number_of_rooms int,
room_typeID int,
foreign key (room_typeID) references room_type(room_typeID),
reservationID int,
foreign key (reservationID) references reservation(reservationID),
reserved_room_status varchar(20)
);

select * from reserved_room

insert into reserved_room
values (4, 1, 1, 'kõik korras')

insert into reserved_room
values (2, 3, 2, 'hästi')

insert into reserved_room
values (1, 2, 3, 'kõik korras')

```
<img width="517" height="97" alt="{48E03222-9FD0-46AC-B9AA-1CE716036CA9}" src="https://github.com/user-attachments/assets/82a27e93-0c43-47b3-b6f3-0fd9acea0f9e" />

- occupied_room
```sql
--6. occupied_room
drop table occupied_room


create table occupied_room(
occupied_roomID int primary key identity(1,1),
check_in date,
check_out date,
roomID int,
foreign key(roomID) references room(roomID),
reservationID int,
foreign key(reservationID) references reservation(reservationID));

select * from occupied_room

insert into occupied_room
values('2026-1-1', '2026-2-1',1,1)

insert into occupied_room
values('2025-12-1', '2026-5-12',2,2)

insert into occupied_room
values('2024-1-13', '2026-2-1',3,3)
```
<img width="422" height="109" alt="{73B9F24D-422A-46C3-9C2F-5F9F708EA96D}" src="https://github.com/user-attachments/assets/9abad85b-ecd2-4c8c-a5be-d0d7998e1210" />

- hosted_at
```sql
--7. hosted_at
create table hosted_at(
hosted_atID int primary key identity(1,1),
guestID int,
foreign key(guestID) references guest(guestID),
occupied_roomID int,
foreign key(occupied_roomID) references occupied_room(occupied_roomID),
);

select * from hosted_at


insert into hosted_at
values(1,1);

insert into hosted_at
values(2,3);

insert into hosted_at
values(3,2);
```
<img width="321" height="115" alt="{E35FA1A1-2AE4-4ACF-B3FE-5BE3BAD9CF45}" src="https://github.com/user-attachments/assets/fd8236f5-3c9f-43e1-a7b1-f452a8070e12" />
### kõik diogramm
<img width="559" height="754" alt="{E5500B0F-A48B-49D3-812E-7FDDB676A991}" src="https://github.com/user-attachments/assets/6c04f1c9-79d4-48cf-9057-242faf877ca2" />
