--22.03.2023 Çarşamba 503 SQL

-------------JOIN işlemleri---------------------------
--Join birleştirmek anlamına gelir
-- En az 2 tablonun birleştirilmesi için kullanılır
--Join Çeşitleri--
--inner join (kesişim)
--left join (soldan)
--right (sağdan)
--outter(full) join 
--cross join (kartezyen)
--self join ( joinin aynı tablolar üzerinde yapılmış haline verilen isim)
--composite join 

--ÖRN: 10248 numaralı siparişi kim satmış ve hangi kargo göndermiş
use NORTHWND
select  o.OrderID [Sipariş No], 
 e.Title + ' '+e.FirstName+ ' ' + e.LastName [Satışı Yapan Çalışan] ,
s.CompanyName [Kargo Firması]
from Orders o (nolock)
join Employees e on e.EmployeeID=o.EmployeeID
join Shippers s on o.ShipVia= s.ShipperID
where o.OrderID=10248

--left join 
-- Hiç sipariş verilmemiş ürünler
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
-- Hiç ödünç alınmayan kitaplar
use OduncKitapDB
select * from OduncIslemler odnc -- table 1
right join Kitaplar k -- ana tablo table 2 yerine yazılır
on k.Id=odnc.KitapId
where odnc.Id is null

select * from Kitaplar k -- table 1
left join OduncIslemler odnc -- ana tablo table 2 yerine yazılır
on k.Id=odnc.KitapId
where odnc.Id is null

--left
-- Hiç sipariş verilmemiş ürünler
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
-- join işleminde aynı tablo kullanıldığında özel isim alıyor
use NORTHWND
select clsn.FirstName + ' '+ clsn. LastName [Çalışan],
mdr.FirstName + ' ' + mdr.LastName [Bağlı Olduğu Üstü]
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

-- Gamze Turap -Laura Callahan onun amiri olacak şekilde ekler misiniz

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
		  'Beşiktaş'  , 'ist', 'Avrupa yakası', '34700','TR', null,
		  null, null, null, 
		  (select EmployeeID from Employees where FirstName ='Laura' and LastName ='Callahan')
		  , null )


		  select * from Employees where FirstName ='Laura' and LastName ='Callahan' 
		  -- yeni açlışan ekledik
		  INSERT INTO [dbo].[Customers]
           ([CustomerID]           ,[CompanyName]
           ,[ContactName]           ,[ContactTitle]
           ,[Address]           ,[City]
           ,[Region]           ,[PostalCode]
           ,[Country]           ,[Phone]           ,[Fax])
     VALUES
         ('ZEYNP', 'Wissen Akademi', 'Zeynep Köroğlu', 'Software developer', 
		 'Beşiktaş', 'İST', 'Avrupa Yakası', '34700','TR', null, null),
		 ('EDAKL', 'Wissen Akademi', 'Eda Kılınç', 'Software developer', 
		 'Beşiktaş', 'İST', 'Avrupa Yakası', '34700','TR', null, null)




		 


--composite join
 --Çalışanlarımla aynı şehirde olan müşteriler
 use NORTHWND
 select * from Customers c
 join Employees e on
 e.Country=c.Country and e.City=c.City
and e.PostalCode=c.PostalCode

 --cross(kartezyen) join --> olasılık
select e.FirstName , e.LastName,  e2.LastName
from Employees e
cross join Employees e2 
--11 ^2 =121







