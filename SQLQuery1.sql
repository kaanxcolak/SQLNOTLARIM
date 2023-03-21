--20.03.2023 503 SQL 
-- Sql komutlarýnda büyük küçük harf kullanýlabilir

create DatABaSE BetulDenemeDB

--tablo oluþturalým
use CafeDB
create table CalisanTipleri (
Id int not null identity(1,1) primary key,
Tip_Adi nvarchar(50) not null
)

create table Calisanlar(
Id int identity(1,1),
Calisan_Tipi_Id int not null,
Eklenme_Tarihi datetime2(7) not null,
IseBaslamaTarihi datetime not null,
Ad nvarchar(50) not null,
Soyad nvarchar(50) not null,
Dogum_Tarihi date,
Cep char(10),
AktifMi bit,
Primary Key(Id)
)


create table Cafe_Kat(
Id int,
CafeId int,
KatId int,
KatAcikMi bit
)

alter table Cafe_Kat
Alter column CafeId int not null
alter table Cafe_Kat
Alter column KatId int not null
alter table Cafe_Kat
Alter column KatAcikMi bit not null

alter table Cafe_Kat
Alter column Id int not null

Alter table Cafe_Kat
ADD CONSTRAINT PK_Cafe_Kat  PRIMARY KEY (Id)

--todo Cafe_Kat tablosu identity l

create table CafeKat_Masa(
Id int not null identity(1,1) primary key,
Cafekat_id int not null,
Masa_Id int not null
)

create table Siparisler(
Id int not null identity(1,1) primary key,
CafeKat_Masa_Id int not null,
UrunId int not null,
Adet tinyint not null,
Tutar decimal(18,2) not null,
GarsonId int not null
)
create TABLE Hesaplar(
Id int primary key  not null identity(1,1) ,
Tarih datetime not null,
SiparisId int not null,
ToplamTutar decimal(18,2) not null
)
-----foreign key-----
--ALTER TABLE Orders
--ADD FOREIGN KEY (PersonID) REFERENCES Persons(PersonID)


alter table Cafe_Kat
add foreign key ([CafeId]) references [dbo].[Cafeler] ([Id])

alter table Cafe_Kat
add foreign key (KatId) references Katlar (Id)