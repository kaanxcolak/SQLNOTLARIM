--22.03.2023 Çarþamba 503 SQL

-------------JOIN iþlemleri---------------------------
--Join birleþtirmek anlamýna gelir
-- En az 2 tablonun birleþtirilmesi için kullanýlýr
--Join Çeþitleri--
--inner join (kesiþim)
--left join (soldan)
--right (saðdan)
--outter(full) join 
--cross join (kartezyen)
--self join ( joinin ayný tablolar üzerinde yapýlmýþ haline verilen isim)
--composite join 

--ÖRN: 10248 numaralý sipariþi kim satmýþ ve hangi kargo göndermiþ
use NORTHWND
select  o.OrderID [Sipariþ No], 
 e.Title + ' '+e.FirstName+ ' ' + e.LastName [Satýþý Yapan Çalýþan] ,
s.CompanyName [Kargo Firmasý]
from Orders o (nolock)
join Employees e on e.EmployeeID=o.EmployeeID
join Shippers s on o.ShipVia= s.ShipperID
where o.OrderID=10248

--left join 
-- Hiç sipariþ verilmemiþ ürünler
select  p.ProductName from Products p (nolock)
left join [Order Details] od (nolock) on p.ProductID= od.ProductID
where od.OrderID is null

-- yeni ürün ekledik
INSERT INTO [dbo].[Products]
           ([ProductName],[SupplierID]
           ,[CategoryID]
           ,[QuantityPerUnit]
           ,[UnitPrice]
           ,[UnitsInStock]
           ,[UnitsOnOrder]
           ,[ReorderLevel]
           ,[Discontinued])
     VALUES ( '503 deneme',10,5,'100 boxes',503,100,255,10,0 ),
			( '5030 deneme',10,5,'25 boxes',503,100,255,10,1 ),
			( '5031 deneme',10,5,'30 boxes',503,100,255,10,1 ),
			( '5032 deneme',10,5,'50 boxes',503,100,255,10,1 )

--right join
-- Hiç ödünç alýnmayan kitaplar
use OduncKitapDB
select * from OduncIslemler odnc -- table 1
right join Kitaplar k -- ana tablo table 2 yerine yazýlýr
on k.Id=odnc.KitapId
where odnc.Id is null

select * from Kitaplar k -- table 1
left join OduncIslemler odnc -- ana tablo table 2 yerine yazýlýr
on k.Id=odnc.KitapId
where odnc.Id is null

--left
-- Hiç sipariþ verilmemiþ ürünler
use NORTHWND
select  * from Products p (nolock)
left join [Order Details] od (nolock) on p.ProductID= od.ProductID
where od.OrderID is null

--right join
select * from [Order Details] odetay (nolock)
right join Products p (nolock) 
on p.ProductID=odetay.ProductID
where odetay.OrderID is null

-- self join
-- join iþleminde ayný tablo kullanýldýðýnda özel isim alýyor
use NORTHWND
select clsn.FirstName + ' '+ clsn. LastName [Çalýþan],
mdr.FirstName + ' ' + mdr.LastName [Baðlý Olduðu Üstü]
from Employees clsn (nolock)
 left join Employees mdr(nolock) 
on clsn.ReportsTo = mdr.EmployeeID


use NORTHWND

select *
from Employees clsn (nolock)
 left join Employees mdr(nolock) 
on clsn.ReportsTo = mdr.EmployeeID

select *
from Employees mdr (nolock)
 right join Employees clsn(nolock) 
on clsn.ReportsTo = mdr.EmployeeID

--outer join
use OduncKitapDB
select * from Kitaplar k (nolock)
full outer join Turler t (nolock) 
on t.Id=k.TurId

select * from Kitaplar k (nolock)
full outer join OduncIslemler oi
on oi.KitapId= k.Id

select * from Kitaplar k (nolock)
left join OduncIslemler oi
on oi.KitapId= k.Id

use NORTHWND
SELECT *
FROM Customers
FULL OUTER JOIN Orders ON Customers.CustomerID=Orders.CustomerID
where Customers.ContactName like '%eda%' or ContactName like '%zeynep%'

use NORTHWND
SELECT *
FROM Orders -- anda tablo
left JOIN  Customers on Customers.CustomerID=Orders.CustomerID



use NORTHWND
SELECT *
FROM Customers
right JOIN  Orders -- ana tablo table 2
on Customers.CustomerID=Orders.CustomerID





select  * from Orders
where CustomerID is null or CustomerID = ''


--select * from Employees

-- Gamze Turap -Laura Callahan onun amiri olacak þekilde ekler misiniz

INSERT INTO [dbo].[Employees]
           ([LastName]           ,[FirstName]           ,[Title]
           ,[TitleOfCourtesy]           ,[BirthDate]           ,[HireDate]
           ,[Address]           ,[City]           ,[Region]
           ,[PostalCode]           ,[Country]
           ,[HomePhone]           ,[Extension]           ,[Photo]           ,[Notes]
           ,[ReportsTo]           ,[PhotoPath])
     VALUES
          ('Turap', 'Gamze', 'Software Developer', 'Miss', '19921114',
		  getdate(),
		  'Beþiktaþ'  , 'ist', 'Avrupa yakasý', '34700','TR', null,
		  null, null, null, 
		  (select EmployeeID from Employees where FirstName ='Laura' and LastName ='Callahan')
		  , null )


		  select * from Employees where FirstName ='Laura' and LastName ='Callahan' 
		  -- yeni açlýþan ekledik
		  INSERT INTO [dbo].[Customers]
           ([CustomerID]           ,[CompanyName]
           ,[ContactName]           ,[ContactTitle]
           ,[Address]           ,[City]
           ,[Region]           ,[PostalCode]
           ,[Country]           ,[Phone]           ,[Fax])
     VALUES
         ('ZEYNP', 'Wissen Akademi', 'Zeynep Köroðlu', 'Software developer', 
		 'Beþiktaþ', 'ÝST', 'Avrupa Yakasý', '34700','TR', null, null),
		 ('EDAKL', 'Wissen Akademi', 'Eda Kýlýnç', 'Software developer', 
		 'Beþiktaþ', 'ÝST', 'Avrupa Yakasý', '34700','TR', null, null)




		 


--composite join
 --Çalýþanlarýmla ayný þehirde olan müþteriler
 use NORTHWND
 select * from Customers c
 join Employees e on
 e.Country=c.Country and e.City=c.City
and e.PostalCode=c.PostalCode

 --cross(kartezyen) join --> olasýlýk
select e.FirstName , e.LastName,  e2.LastName
from Employees e
cross join Employees e2 
--11 ^2 =121

-------------------------------------------------------------------------------------------------
--FUNCTIONS 
-- MATHEMATICAL FUNCTIONS
select PI()
select pi() Sonuc
select power(2,3) as Sonuc
select power(2,3)  Sonuc
select sqrt(81)
select CEILING(9.00000001)
select floor(9.999999999999)
select round(9.26425,5)

-- DateTime Function
select getdate()
select year(getdate())
select month(getdate())
select day(getdate())
select month ('20230322')

select dateadd(day,3,getdate())
select dateadd(month,-3,getdate())
select dateadd(year,10,getdate())
select dateadd(day,3,'20230322')

--ÖRN: Sipariþler verildiði tarihten itibaren tahmini 3 gün sonra kargolanacaktýr

select o.OrderID, o.OrderDate,
DATEADD(day,3, o.OrderDate) TahminiKargoTarihi
from Orders o (nolock)

-- dateddiff 2 tarih arasýndaki farký alýr
select DATEDIFF(day, '20220322', '20230322')
select DATEDIFF(month, '20220322', '20230322')
select DATEDIFF(year, '20220322', '20230322')

--ÖRN: Sipariþin verildiði ve kargolandýðý tarih arasýnda kaç gün geçmiþtir?
select o.OrderID, o.OrderDate, o.ShippedDate,
DATEDIFF(day,o.OrderDate, o.ShippedDate) [Kaç Günde Kargolanmýþtýr? ]
from Orders (nolock) o
where o.ShipVia =3
and DATEDIFF(day,o.OrderDate, o.ShippedDate) > 20


select o.OrderID, o.OrderDate, o.ShippedDate,
c.CompanyName, c.ContactName, c.Phone,
DATEDIFF(day,o.OrderDate, o.ShippedDate) [Kaç Günde Kargolanmýþtýr? ]
from Orders (nolock) o
join Customers c on c.CustomerID=o.CustomerID
where o.ShipVia =3
and DATEDIFF(day,o.OrderDate, o.ShippedDate) > 20

--String Functions
select ASCII('a')
select char(97)
--
select CHARINDEX('a', 'pli ata bak')
select left ('betül',3)
select right ('betül',3)

--trim ifadeki sað ve soldaki boþluklarý siler
select trim ('     betül akþan    ')
select ltrim ('      betül     ')
select rtrim ('      betül     ')

-- substring ifadenin içinden bir kýsým keser/alýr
select SUBSTRING('betül akþannnnnnnnnnnnnnnnnnnnnnnnn',5,3)
--replace : yerine baþka bir deðer vermek
select REPLACE('betül', 'tül', 'XXX')

select len('b e t ü l') -- boþluðu da sayar

--concat birleþtirmek
select CONCAT('betül', ' ', 'akþan')

select CONCAT(e.FirstName, ' ', e.LastName) [Ýsim Soyisim]
from Employees e

--str : içine yazýlýn ifayi stringe çeviri
select str(75,3) -- ikinci parametre stringe dönüþtüðünde kaç karakter oalcaðýný belirler
-- fonksiyon içinde fonksiyon kullanýlabilir
select trim(str(503))

select len(str(75.858585899,10,5))
select str(75.811181899,10,2)
 
-- 22/03/2023

select concat( trim(str(day(o.OrderDate))),' / ',
trim(str(month(o.OrderDate))), ' / ',
trim(str(year(o.OrderDate))))
from Orders o

-- 
select CONCAT(day(o.OrderDate),' / ',MONTH(o.OrderDate),' / ',YEAR(o.OrderDate)) 
from Orders o(nolock)
-----------------------------------------------------
--case when then
--rownumber()
--order by
--aggregate functions
--group by having
--sub query
--view
--stored function
--Trigger
-- Transaction 

-----------------------------------------------------
--order by
-- Artan ya da Azalan sýralama yapar 
-- ORDER BY ifadesinden sonra 
--Tek bir kolon varsa tek kolona göre
-- Birden çok kolon varsa önce ilki sonra diðerine göre sýralar
use OduncKitapDB
select * from Kitaplar
where KitapAdi like '%harry%'
order by KitapAdi desc

select * from Kitaplar
order by StokAdeti,
KitapAdi desc, TurId desc

use NORTHWND
select o.OrderID, o.OrderDate, o.ShippedDate,
DATEDIFF(day,o.OrderDate, o.ShippedDate) [Kaç Günde Kargolanmýþtýr? ]
from Orders (nolock) o
where o.ShipVia =3
and DATEDIFF(day,o.OrderDate, o.ShippedDate) > 20
order by [Kaç Günde Kargolanmýþtýr? ] 
---------------------------------------------------
--case when then
--Örn: Her satýr için discount > 0 ise Ýnidirmli deðilse indirimsiz yazan kolonu oluþturalým.
select * ,
case 
when od.Discount >0 then 'Ýndirimli'
else 'Ýndirimsiz'
end [Ýndirim Durumu]
from [Order Details] od (nolock)
--ÖRN: Sipariþ detay tablosundaki her satýrdaki ürün için eðer
-- Quantity <3 ise Stok Tükeniyor yazsýn 10 ile  50 arasýnda isem Kampanyay Uygun Ürün yazsýn 50den büyükse Müdür Onayý Gerekli Hiçbirine uymuyorsa ---- Yazsýn.

select od.OrderID, od.ProductID, od.Quantity,
case 
when od.Quantity <3 then 'STOK TÜKENÝYOR'
when od.Quantity between 10 and 50 then 'KAMPANYAYA UYGUN ÜRÜN'
WHEN od.Quantity > 50 then 'Müdür Onayý Gerekli'
else '-----'
end [Quantity'e Göre Durumlar]
from [Order Details] od

--ÖRN: Sipariþ tablosundaki shipcountry alanýna bakalým
-- içinde xx geçen kolonlara puan verelim
select o.OrderID, o.ShipCountry,
case 
when o.ShipCountry like '%an%' or o.ShipVia=3
then 100
else 0
end [Kargo Ülke Puaný]
from Orders o (nolock)

--rownumber() : Veriye satýr numarasý ekleyen fonksiyon

select ROW_NUMBER() over (order by p.CategoryId desc) SýraNo,
p.ProductName, p.CategoryID, p.UnitPrice
from Products p (nolock)

use OduncKitapDB
select  row_number() over (order by k.SayfaSayisi desc) SýraNo
,*
from Kitaplar k (nolock)

use OduncKitapDB
select  row_number() over (order by k.SayfaSayisi desc) SýraNo
,k.KitapAdi, t.TurAdi, concat(y.YazarAdi, ' ', y.YazarSoyadi),
k.SayfaSayisi
from Kitaplar k (nolock)
join Turler t on t.Id=k.TurId
join Yazarlar y on y.Id= k.YazarId
--------------------------------------------------------------
--Aggregate Functions 
--SUM: Bir sütundaki verileri toplar
--MAX: Bir kolondaki veriler arasýndan en büyük olaný verir
--MIN: Bir kolondaki veriler arasýndan en küçük olaný verir
--AVG: Bir kolondaki verilerin/deðerlerin ortalamasýný alýr.
--COUNT: Bir kolondaki verilerin sayýsýný verir.
------------
--DÝPNOT: Hesaplama Fonksiyonlarý NULL olan deðerleri dikkate almazlar!
use NORTHWND
select count(*) from Customers
select count(region) from Customers

select  max (Unitprice) [En Pahalý Ürünü Fiyatý] from Products
select  min (Unitprice) [En Ucuz Ürünü Fiyatý] from Products
select  avg (Unitprice) [Ortalama Ürünü Fiyatý] from Products
select  sum (Unitprice) [Toplam Ürün Fiyatý] from Products

create table Deneme(
Id int identity(1,1) primary key,
Deger int null
)
insert into Deneme (Deger) values (null), (null), (150), (200), (null), (50)
select avg (deger) from Deneme --null deðerleri dikakte almaz 800 /6 =133

select avg(isnull(Deger,0)) Sonuç from Deneme -- 800/8
select count(isnull(region, '')) from Customers
--------------------------------------------------------------
create table Deneme2(
Id int identity(1,1) primary key,
Deger int null
)
------------------------------------------------------------

select count(*) from Deneme3

create table Deneme3(
Id int null,
Deger int null
)
------------------------------------------------
-- Group By : Gruplama yapmak için kullanýlýr
-- having
-- Genellikle aggregate func ile kullanýlýr.

--ÖRN: Hangi ülkede kaç müþterim var?
select c.Country, count(*) [Müþteri Sayýsý]
from Customers (nolock) c
group by c.Country
--order by [Müþteri Sayýsý] desc
order by c.Country desc
 
select  c.City, count(*) [Müþteri Sayýsý]
from Customers (nolock) c
group by c.Country, c.City
order by [Müþteri Sayýsý] desc
--order by c.Country desc

-- Kitaplar tablosunda yazarýn kaç adet kitabý var ?
use OduncKitapDB
select y.YazarAdi, y.YazarSoyadi,
count(*) [Kitap Sayýsý] 
from Kitaplar k (nolock)
join Yazarlar y (nolock) on k.YazarId= y.Id
group by y.YazarAdi, y.YazarSoyadi

select count(*) from Kitaplar where YazarId=8

select * from Kitaplar where YazarId in (17)

update Kitaplar set YazarId=17 where Id=8
update Kitaplar set YazarId=17 where Id=61
update Kitaplar set YazarId=17 where Id=65
update Kitaplar set YazarId=17 where Id=66

--having: Having ile Group by ile grupladýðýnýz kolonu ya da agregate func iþleminin sonucunu koþula tabi tutabilirsiniz.
--ÖRN: Hangi ülkede 5'ten fazla müþterim var?
use NORTHWND
select c.Country, count(*) [Müþteri Sayýsý]
from Customers (nolock) c
group by c.Country
having count(*) > 5 and c.Country !='USA'
order by c.Country desc

--DÝPNOT: Performans açýsýndan bu daha iyidir
-- NEDEN? Çünkü önce datadan USA'leri çýakrttý sonra grupladý
--sonra grupladýðýndan 5'ten büyükleri getirdi.
select c.Country, count(*) [Müþteri Sayýsý]
from Customers (nolock) c
where c.Country !='USA'
group by c.Country
having count(*) > 5
order by c.Country desc

--ÖRN: Ürün bazýnda ciro
select od.ProductID, p.ProductName ,
sum(od.UnitPrice * od.Quantity* (1- od.Discount)) [Ciro]
from [Order Details] od (nolock)
join Products p (nolock) on p.ProductID= od.ProductID
group by  od.ProductID, p.ProductName

select  p.ProductName ,
sum(od.UnitPrice * od.Quantity* (1- od.Discount)) [Ciro]
from [Order Details] od (nolock)
join Products p (nolock) on p.ProductID= od.ProductID
group by   p.ProductName
order by Ciro desc


--ÖRN: En çok alýþveriþ yapan müþteri
select top 1 o.CustomerID, c.CompanyName,
count(*) [Alýþveriþ Sayýsý] 
from Orders o (nolock)
join Customers c (nolock) on c.CustomerID= o.CustomerID
group by o.CustomerID, c.CompanyName
order by [Alýþveriþ Sayýsý]  desc

--ÖRN: En çok satýþ yapan çalýþan
select top 1 o.EmployeeID, e.FirstName, e.LastName,
count(*) [Satýþ Sayýsý]
from Orders (nolock) o
join Employees e (nolock) on e.EmployeeID= o.EmployeeID
where e.City='London'
group by o.EmployeeID, e.FirstName, e.LastName
order by [Satýþ Sayýsý] desc

---Türe göre ödünç iþlem sayýsý 
use OduncKitapDB
select t.TurAdi, count(*) [Ödünç alýnma sayýsý]
from OduncIslemler o
join Kitaplar k on o.KitapId= k.Id
join Turler t on t.Id= k.TurId
group by t.TurAdi

-- örn: Hangi kitap kaç kere ödünç alýnmýþ

--ÖRN: 1996 yýlýnda en az kazandýran çalýþaným

--ÖRN: 2006 yýlýnda kazancý min 7000 olup birim fiyatý min 20 ve içinde ff geçmeyen ürünlerden kazandýðým