USE AKBILDB

create table Kullanicilar(
Id int identity(1,1) primary key,
EklenmeTarihi datetime2(7) not null,
Email varchar(50) not null,
Parola varchar(50) not null,
Ad nvarchar(50) not null,
Soyad nvarchar(50) not null,
DogumTarihi date null,
)

create table Akbiller(
AkbilNo char(16) primary key,
EklenmeTarihi datetime2(7) not null,
AkbilTipi nvarchar(50) not null,
Bakiye decimal(18,2) not null,
AkbilSahibiId int not null,
VizelendigiTarih datetime2(7) null
)

create table Talimatlar(
Id int identity(1,1) primary key,
EklenmeTarihi datetime2(7) not null,
AkbilId char(16) not null,
YuklenecekTutar decimal(18,2) not null,
YuklendiMi bit not null,
YuklenmeTarihi datetime2(7) null,
)

---------------------------------------------------------------------------------------------------------
