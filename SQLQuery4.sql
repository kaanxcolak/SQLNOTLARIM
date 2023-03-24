--23.03.2023 
---SELECT SORGUSUNUN ÇALIŞMA SIRASI
-- 1) FROM 
-- 1,5) Varsa join join çalışır yoksa 2'ye geç
-- 2) WHERE 
-- 3) Varsa Group by çalışır
-- 4) HAVING çalışır
-- 5) SELECT çalışır
-- 6) ORDER BY çalışır --> Alias kullanılabilir (Select'ten sonra çalıştığı için)
-- ÖRN: Hangi kitap kaç kere ödünç alınmış
---------------------------------------------------------
--use OduncKitapDB
--select k.KitapAdi [Kitap Adı], COUNT(*) [Ödünç Alma Sayısı]
--from Kitaplar k (nolock) --table 1
--join OduncIslemler od (nolock) on od.KitapId = k.Id --table 2
--group by k.KitapAdi
--select * from Kitaplar 
--select * from OduncIslemler 
---------------------------------------------------------
--ÖRN: Kitap Yedek isimli bir tablo olmalı. Kitaplar tablosundan kayıt güncellendiğinde bir önceki halinin bilgileri KitaplarYedek tablosuna eklensin
create trigger tg_KitapYedek
on Kitaplar
instead of update
as begin  
declare @kayitTarihi datetime2(7),@kitapAdi nvarchar(50),
@turId tinyint, @yazarId int, @sayfa int, @stok int,
@resimLink char(100), @silindiMi bit, @id int

select @kayitTarihi=KayitTarihi, @kitapAdi=KitapAdi,
@turId=TurId, @yazarId=YazarId,@sayfa=SayfaSayisi,
@stok=StokAdeti, @resimLink=ResimLink, @silindiMi=SilindiMi,
@id=Id
from inserted
insert into KitaplarYedek (id,)

end







insert into OduncIslemler (KayitTarihi, UyeId,KitapId,PersonelId,OduncAlinmaTarihi,OduncBitisTarihi,TeslimEttigiTarih,TeslimEttiMi) 
values (GETDATE(),1,68,1,GETDATE(),DATEADD(DAY,30,GETDATE()),null,0)


insert into OduncIslemler (KayitTarihi, UyeId,KitapId,PersonelId,OduncAlinmaTarihi,OduncBitisTarihi,TeslimEttigiTarih,TeslimEttiMi) 
values (GETDATE(),1,68,1,GETDATE(),DATEADD(DAY,30,GETDATE()),null,0)




--23.03.2023 503 SQL 
-- örn: Hangi kitap kaç kere ödünç alınmış
use OduncKitapDB
select k.KitapAdi , count(*) [Kaç Kere Ödünç Alınmıştır?]
from OduncIslemler (nolock) odnc
join Kitaplar k (nolock) on k.Id= odnc.KitapId
group by k.KitapAdi

select k.KitapAdi , count(*) [Kaç Kere Ödünç Alınmıştır?]
from Kitaplar k (nolock) 
join OduncIslemler odnc (nolock) on k.Id= odnc.KitapId
group by k.KitapAdi

--ÖRN: 1996 yılında en az kazandıran çalışanım
use NORTHWND
select  top 1 concat(e.FirstName ,' ', e.LastName) [Çalışan] , 
count(*) [Satış Sayısı]
from Orders o (nolock)
join Employees e (nolock) on e.EmployeeID=o.EmployeeID
where o.OrderDate >='19960101' and o.OrderDate <'19970101'
group by e.FirstName , e.LastName
order by [Satış Sayısı] 


--ÖRN: 1997 yılında kazancı min 7000 olup birim fiyatı min 20 ve içinde ff geçmeyen ürünlerden kazandığım
select top 10 * from [Order Details]
select p.ProductName , sum(od.UnitPrice * od.Quantity * (1- od.Discount)) [Kazanç] 
from [Order Details] od (nolock)
join Orders o (nolock) on o.OrderID=od.OrderID
join Products p (nolock) on p.ProductID=od.ProductID
where od.UnitPrice >=20 and p.ProductName not like '%ff%'
and o.OrderDate >='19970101' and o.OrderDate <'19980101'
group by p.ProductName
having sum(od.UnitPrice * od.Quantity * (1- od.Discount))  >=7000

--cast komutu
select cast(13948.6799926758 as decimal(18,0))

select p.ProductName , cast(sum(od.UnitPrice * od.Quantity * (1- od.Discount)) as decimal(18,2)) [Kazanç] 
from [Order Details] od (nolock)
join Orders o (nolock) on o.OrderID=od.OrderID
join Products p (nolock) on p.ProductID=od.ProductID
where od.UnitPrice >=20 and p.ProductName not like '%ff%'
and o.OrderDate >='19970101' and o.OrderDate <'19980101'
group by p.ProductName
having sum(od.UnitPrice * od.Quantity * (1- od.Discount))  >=7000


---SELECT SORGUSUNUN ÇALIŞMA SIRASI
-- 1) FROM 
-- 1,5) Varsa join join çalışır yoksa 2'ye geç
-- 2) WHERE 
-- 3) Varsa Group by çalışır
-- 4) HAVING çalışır
-- 5) SELECT çalışır
-- 6) ORDER BY çalışır --> Alias kullanılabilir (Select'ten sonra çalıştığı için)

-----------------------------------------------------------------------------
--delete işlemi DML komutu
--> hard delete  --> delete komutunu yazarak tablodan o veriyi yok etmek / silmek
--> soft delete --> Tabloya SlindiMi/ AktifMi gibi kolonlar ekleyerek bu kolonları güncellemek
use OduncKitapDB
delete from Kitaplar where Id=67 --hard delete

update Kitaplar set SilindiMi=1 where Id=53 --> (soft delete) UPDATE İŞLEMİDİR

select * from Kitaplar where KitapAdi like '%cam%'

--case when then
--rownumber()
--order by
--aggregate functions
--group by having
--delete
--sub query
--değişken , döngü
--view
--stored function
--Trigger
-- Transaction 
-------------------------------------------------------------------------------
--View: Kod ile de oluşturulur. Object Explorer penceresinden Views >> New View ile designer penceresinden de oluşturulur.

create View KitapTurYazarView
as
select k.Id, k.KayitTarihi,k.KitapAdi, t.TurAdi,
concat(y.YazarAdi, ' ', y.YazarSoyadi) [Yazar], k.SayfaSayisi, k.StokAdeti,
k.ResimLink, k.SilindiMi
from Kitaplar k (nolock)
join Yazarlar y (nolock) on y.Id=k.YazarId
join Turler t (nolock) on t.Id=k.TurId
 use NORTHWND
alter view ProductCiro1997
as 
select   p.ProductID, p.ProductName , sum(od.UnitPrice * od.Quantity * (1- od.Discount)) [Kazanç] 
from [Order Details] od (nolock)
join Orders o (nolock) on o.OrderID=od.OrderID
join Products p (nolock) on p.ProductID=od.ProductID
where od.UnitPrice >=20 and p.ProductName not like '%ff%'
and o.OrderDate >='19970101' and o.OrderDate <'19980101'
group by p.ProductName, p.ProductID


use OduncKitapDB 
select * from KitapTurYazarView

-------------------------------------------------------------
--sub query: Alt sorgu anlamına gelir. İç-içe select sorgusu  yazmaktır.
--ÖRN: Shipper Speedy Express isimli kargoyla verilen siparişler
use NORTHWND
select * from Orders o (nolock)
where o.ShipVia =
(select ShipperID from Shippers where CompanyName='Speedy Express')

-- Derived Türetilmiş tablo :
--Parantez içine alınan Altsorguya TAKMA İSİM (alias) verilerek
--türetilmiş tablo haline getirip kullanabilirsiniz.
--ÖRN: Kargoda 30 günü aşan siparişler 

select * from
(
select o.OrderID, o.OrderDate, o.ShippedDate,
DATEDIFF(day, o.OrderDate, o.ShippedDate) [Kaç Günde Kargolandi?]
from Orders (nolock) o ) kargoGunleri
where [Kaç Günde Kargolandi?] >35

--ÖRN ***** 35 günü aşan kargoya verme işlemi problem oluşturmakatadır. (başarısız gönderim işlemi sayılmaktadır) Firmanın yıl bazında kaç defa başarısız gönderim işlemi olmuştur?

select year(kargoGunleri.OrderDate) Yıl , count(*) [Kaç Kere başarısız gönderim işlemi Olmuş?]
from 
(select o.OrderID, o.OrderDate, o.ShippedDate,
DATEDIFF(day, o.OrderDate, o.ShippedDate) [Kaç Günde Kargolandi?]
from Orders (nolock) o 
where DATEDIFF(day, o.OrderDate, o.ShippedDate) > 35) kargoGunleri 
group by year(kargoGunleri.OrderDate)

-------------------------------------------------------------------
select yılSonuc.OrderYear, sum(yılSonuc.[Kaç Kere başarısız gönderim işlemi Olmuş?]) HowManyTimesCargoFailed  from
(
select year(kargoGunleri.orderdate) [OrderYear], count(*) [Kaç Kere başarısız gönderim işlemi Olmuş?]
from 
	(
	select o.OrderID,o.OrderDate, DATEDIFF(day,o.OrderDate, o.ShippedDate) [Kaç Günde Kargolandi?]
	from Orders o) as kargoGunleri
	where kargoGunleri.[Kaç Günde Kargolandi?] > 30
	group by kargoGunleri.OrderDate)
	as yılSonuc
group by yılSonuc.OrderYear
--------------------------------------------------------------------
--Değişken, Koşul, Döngü
--değişken tanımlama
declare @durum nvarchar(6)
set @durum= 'denemfdgfdgdfge'

--select @durum Sonuc

select
case 
@durum when 'deneme' then 'EVET deneme yazıyor'
else 'HAYIR deneme Yazmıyor'
end Sonuc 

-- if kullanımı 
declare @sayi int
Set @sayi =200
if(@sayi > 100)
begin 
select 'Bu sayı 100de  büyüktür' Sonuc
end
else
begin 
select 'Bu sayı 100den  küçüktür' Sonuc
end

--döngü while
declare @sayac int , @sonuc int
set @sayac=1 set @sonuc=1
while (@sayac < 6 )
begin
if (@sayac =1) begin break end
set @sonuc+=@sayac
set @sayac+=1
end 
print concat('Sonuç =', @sonuc)
select concat('Sonuç =', @sonuc)

--ÖRN: İçinde cam olan kitap var mı? EVET HAYIR

--use OduncKitapDB
--declare @kitapAdi nvarchar(50)
--set @kitapAdi='erDeNER'
--if(EXISTS(select * from Kitaplar k (nolock)
--where k.KitapAdi like '%'+@kitapAdi+'%' ))
--begin
--print 'Bu kitaptan VAR'
--end
--else
--begin
--select 'Bu kitaptan YOK!' Sonuc
--end


use OduncKitapDB
declare @kitapAdi nvarchar(50)
set @kitapAdi='er'
if(EXISTS(select * from Kitaplar k (nolock)
where k.KitapAdi like '%'+@kitapAdi+'%' ))
begin
-- kitabın türünü istiyor
select t.TurAdi from Turler t (nolock) 
where t.Id in (select k.TurId from Kitaplar k (nolock)
where k.KitapAdi like '%'+@kitapAdi+'%' )
end
else
begin
select 'Bu kitaptan YOK!' Sonuc
end

-----------------------------------------------------------------------
-- Stored Procedure 
-- C# dilindeki metotlara karşılık gelir.
--Parametreli, parametresiz ve geriye değer gönderebilir (output), geriye değer göndermeyebilir 
--SP kısaltmasıyla bilinirler
-- Tekrar tekrar yazılması /işlenmesi gereken işlemleri tek bir sefer yazıp tekrar tekrar kullanırız.
--
--Parametre almayan bir örnek
--ÖRN: Tüm kitaplar getiren prosedür
create procedure spTumKitaplariGetir
as
begin
select * from Kitaplar (nolock)
end

--SP Nasıl Çağrılır ?
execute spTumKitaplariGetir
exec spTumKitaplariGetir


--parametre alan sp
--ÖRN: Dışardan verilen kitap adını arayıp getiren prosedür

create procedure sp_KitapAra(@kitapAdi nvarchar(50))
as begin
select * from Kitaplar (nolock) 
where KitapAdi like '%'+@kitapAdi +'%'
end

exec sp_KitapAra 'cam'

--Var olan prosedürün içeriğini düzenliyoruz
alter procedure sp_KitapAra(@kitapAdi nvarchar(50))
as begin
declare @adet int
select @adet=count(*) from Kitaplar (nolock) 
where KitapAdi like '%'+@kitapAdi +'%'
if(@adet > 0) 
begin
select concat ('Bu kitaptan ', @adet, ' vardır') Sonuc
end
else 
begin 
select 'Bu kitaptan YOK' Sonuc
end
end 
exec sp_KitapAra 'a'

-- ÖRN: Yeni cafe ekleyen prosedür ile ekleyelim
use CafeDB
create procedure sp_YeniCafeEkle(@trh datetime2(7), @ad nvarchar(50),@adres nvarchar(100),@tel char(13), @katSayisi tinyint)
as 
begin
insert into Cafeler (Eklenme_Tarihi, Iletisim_Telefon, Acik_Adresi,Adi,Kac_Katli) 
values (@trh,@tel,@adres,@ad,@katSayisi)
end

exec sp_YeniCafeEkle '20230323','Betül Cafe','Beşiktaş' , null, 2

--ÖRN: Prosedür ile güncelleme yapalım
use OduncKitapDB
--ÖRN: Dışardan idsini aldığımı kitabın stok adedini 2 katına çıkaran prosedür  
alter procedure sp_Stogu2KatinaCikar (@kitapid int)
as begin
if(exists(select * from Kitaplar (nolock) where Id=@kitapid))
begin
declare @stok int
select @stok= StokAdeti  from Kitaplar (nolock) where Id=@kitapid
update Kitaplar set StokAdeti = @stok  * 2 where Id=@kitapid
end
else
print 'Kitap YOK Stok artışı yapılamaz!'
end

select * from Kitaplar where Id=53 --19 stok
exec sp_Stogu2KatinaCikar 53

--Trigger -- Tetikleyici
--Çağrılmaksızın şartlar sağlandığı sürece otomatik tetiklenen SQL sorgularını yazdığımız yapıdır
-- Triggerlar bir rabloya bağlı olarak çalışır.
--Insert Update Delete işlemlerinden SONRA ya da işlemlerin YERİNE yazılırlar
--Triggerın 2 çeşidi vardır:
--AFTER Trigger: Insert/Update/Delete işlemlerinden SONRA çalışır.
-- INSTEAD OF : Insert/Update/Delete yerien çalışır. Kimin yerine çalışırsa o komutu diskalifiye etmiş gibi düşünebilirsiniz.

--ÖRN: Cafeler tablosuna ekleme yapıldığında tabloyu listeyen trigger
--Ekleme yapılacak sonra listeleme (After trigger)
use CafeDB
create trigger tg_CafeListele
on Cafeler -- hangi tabloya bağlı çalışacak?
after insert -- çeşidi (after) insert(işlem)
as begin
select * from Cafeler
order by Id desc
end

exec sp_YeniCafeEkle '20230323','Test Cafe','Beşiktaş' , null,2

insert into Cafeler (Eklenme_Tarihi, Iletisim_Telefon, Acik_Adresi,Adi,Kac_Katli) 
values ('20230323',null,'Beşiktaş' ,'5031 Cafe',2)

alter trigger tg_CafeListele2
on Cafeler -- hangi tabloya bağlı çalışacak?
after update -- çeşidi (after) insert(işlem)
as begin
select * from Cafeler
order by Id desc
end

--ÖRN: Ödünç işlemden sonra kitaplar tablosunda kitabın stok adedini azaltalım. 
--after insert
use OduncKitapDB
alter trigger tg_StokAzalt
on OduncIslemler
after insert
as begin 
declare @kitapId int, @stok int
select @kitapId= KitapId from inserted
select @stok= StokAdeti  from Kitaplar (nolock) 
where Id=@kitapId
if(@stok >=1)
update Kitaplar set StokAdeti= @stok-1 where Id=@kitapId
end

select * from Kitaplar --68 stok =1  -- 46 stok= 28

insert into OduncIslemler (KayitTarihi, UyeId, KitapId, PersonelId, OduncAlinmaTarihi, OduncBitisTarihi,TeslimEttigiTarih, TeslimEttiMi)
values(getdate(),1,69,1,getdate(),dateadd(DAY,30, getdate()),null,0 )

--instead of Trigger : Komutun yerine çalışır

--ÖRN: Cafeler tablosundan hiç bir kayıt silinemesin

use CafeDB
alter trigger tg_Silemez
on Cafeler
instead of delete
as begin 
select 'KAYIT SİLEMEZSİN!'
end

delete from Cafeler where Id=5

use CafeDB
--Triggerı komut ile disable enable etme işlemi
ALTER TABLE Cafeler DISABLE TRIGGER tg_CafeListele

ALTER TABLE Cafeler ENABLE TRIGGER tg_CafeListele

--Enable Triggers on a Table

Disable TRIGGER ALL ON Cafeler
Enable TRIGGER ALL ON Cafeler 
--Enable Triggers on a Database


ENABLE TRIGGER ALL On DATABASE  ---?

use NORTHWND

select * from Orders where ShipName='Hanari Carnes'

use CafeDB
CREATE UNIQUE INDEX idx_KategoriAdi
ON Kategoriler (Ad);

insert into Kategoriler (Ad) values ('Betül')

CREATE  INDEX idx_Calisanlar
ON Calisanlar (Ad,Soyad)













