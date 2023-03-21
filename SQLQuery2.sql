--21.03.2023 SALI 503 SQL 
-- DML Data Manupulation Language

--insert into tabloAdi (kolon1,kolon2) 
--values (deger1, deger2)
--metinsel, tarih tek tırnak
--ÖRN: Ürünler tablosuna veriler ekleyelim
use CafeDB
insert into Urunler (Birim_Fiyati,Kategori_Id,
Urun_Adi,Birim_Fiyati_Deneme1_182, 
Birim_Fiyati_Deneme2_184, Birim_Fiyati_Deneme3_money)
values (10,2,'Çay', 10.5,10.5556, 10.202)

insert into Urunler
(Urun_Adi,
Kategori_Id,
Birim_Fiyati)
values
('Kahve', --ürün adı
2, -- kategori id
35 -- fiyatı
)

insert into Urunler
(Urun_Adi, Kategori_Id, Birim_Fiyati)
values 
('Limonata', 2 , 30 ),
('Sıcak Çikolata', 2 , 20 ),
('Portakal Suyu', 2 , 20 ),
('Oralet', 2 , 15 )

--> Tabloya sağ TIK Scrip Table menüsünden aldık
GO
INSERT INTO [dbo].[Urunler]
           ([Kategori_Id]
           ,[Urun_Adi]
           ,[Birim_Fiyat]
           ,[Birim_Fiyat_Deneme1_182]
           ,[Birim_Fiyat_Deneme2_184]
           ,[Birim_Fiyat_Deneme3_money])
     VALUES
           (1,'Sütlaç',25,null,null,null),
		   (1,'Kadayıf Dolması',30,30.99,30.9999,30.63)

--DQL Data Query Language
--Select komutu seçme/listeleme yapar
--select kolon adları from Tablo adı
--select * from tabloadi

select * from Urunler
select Urun_Adi,Birim_Fiyat from Urunler
select*,*,* from Urunler   --Kötü ötesi kullanım!
select Birim_Fiyat_Deneme3_money, *from Urunler ----Kötü ötesi kullanım!
select top 3 * from Urunler  --top kullanımı best practice

--no lock 
select * from Urunler (nolock)
select * from Urunler with (nolock)

--Takma isim ALIAS
--1.Nedeni  --> Tabloya takma isim vererek tablo ve kolonlara daha kolay ulaşmak 
--2.Nedeni JOIN konusunda açıklanacak
--3.Nedeni SUBQUERYlerde  derived table'ı isimlendirmek içindir

select u.Urun_Adi as [Cafemizin Çok Güzel Ürünleri],
u.Birim_Fiyat as Bu Ürünün Fiyatı
from Urunler as u --1,2,3,4 harfli takma isim

--Bir tablonun kolonuna tablo olan başka bir kolonu takma isim olarak VERMEYEİNİZ!
select u.Urun_Adi [Cafemizin Çok Güzel Ürünleri],
u.Birim_Fiyat, Kategori_Id  --!!!!!! Bu sorgu 3 Kolonlu mu?
--değilse 2 kolonsa 30 numaralı kategori Yok ki!!!
from Urunler as u --1,2,3,4 harfli takma isim

--kolonlara işlemler yapmak
select 10+10 AS sonuc
select 10+10 sonuc
select 10 + '2000000' sonuc --20
select 10 + 'betul' as sonuc 
select '10' + 'betül' sonuc
select 99.8 + '10'

--ürünlerin ismi, fiyatı üzerine %10 zam yanına kolonuna ihtiyacım var
select u.Urun_Adi, u.Birim_Fiyat [Fiyat TL],
u.Birim_Fiyat * 1.10 [%10 Eklenmiş Yeni Fiyat TL]
from Urunler u

select '21/03/2023' Tarih, u.Urun_Adi, u.Birim_Fiyat [Fiyat TL],
u.Birim_Fiyat * 1.10 [%10 Eklenmiş Yeni Fiyat TL]  
from Urunler 

--WHERE KOMUTU
--Mevcuttaki tabloya bazı koşullar uygulayarak
--tablodaki verilere filtreleme yapabiliriz

use OduncKitapDB
select * from Kitaplar
where KitapAdi = 'Camdaki Kız'

--Sayfa sayısı 350.2den fazla kitaplar
select * from Kitaplar
where SayfaSayisi >=350

--turID 6 olan ve sayfa sayısı 350den fazla olan kitaplar 
select * from Kitaplar
where TurId = 6 and SayfaSayisi >350

select * from Kitaplar
where SayfaSayisi >350 and TurId = 6 

select * from Kitaplar
where SayfaSayisi >350 or TurId = 6 

--Farklı operatörleri aynı anda kullanırsak........ Kullan!
select * from Kitaplar
where SayfaSayisi >350 and (TurId = 6 or TurId = 8)

--Eşit değil, Farklıdır, Not operatörleri

--Sistemdeki turid'si 6 olmayan kitaplar
select *from Kitaplar k (nolock)
where k.TurId !=6 --> EŞİT DEĞİLDİR

select *from Kitaplar k (nolock)
where k.TurId <> 6 --> FARKLIDIR

--NOT operatörü
select * from Kitaplar
where not (TurId = 6 or TurId = 8)

select * from Kitaplar
where not (SayfaSayisi >350 and (TurId = 6 or TurId = 8))

--and or not bir arada kullanılabilir fakat parantez önceliğine dikkat edilmelidir
select * from Kitaplar
where not(YazarId = 1 and SayfaSayisi >400) and StokAdeti>10

select *from Kitaplar
where not YazarId = 19

--WHERE komutunun KULLANIMLARI 
   --1)Karşılaştırma ( <,> =,>=,<=,=!)
   --2)Mantıksal (AND, OR, NOT)
   --3)Aralık sorgulama (between...and)
   --4)Listesel sorgulama (in)
   --5)Like komutu
   --6)Null verileri sorgulama (is)
--3)Aralık sorgulama (between...and)
select * from Kitaplar (NOLOCK) k
where k.SayfaSayisi between 200 and 300 -- değerler dahil!!!!

--Turid 5 olan sayfasayısı >= 200 ve <= 300 (sayfasayısı>= 200 ve <= 300 mantığı var )
select * from Kitaplar (NOLOCK) k
where k.SayfaSayisi between 200 and 300 and k.TurId=5

select * from Kitaplar k (nolock)
where k.KayitTarihi between '20220101' and '20220122'

select * from Kitaplar k (nolock)
where k.KayitTarihi <= '20220114' and k.KayitTarihi>='20220114'

--14 ocak 2022
--best practise TARİH Sorgulama 
select * from Kitaplar k (nolock)
where k.KayitTarihi >= '20220114' and k.KayitTarihi<'20220115'

select * from Kitaplar k (nolock)
where k.KayitTarihi between '20220114' and '20220115'

--2022 ocak ayı
select * from Kitaplar k (nolock)
where k.KayitTarihi > '20211231' and k.KayitTarihi<'20220201'

select * from Kitaplar k (nolock)
where k.KitapAdi between 'Ezbere Yaşayanlar' and 'Momo'

insert into Kitaplar (KayitTarihi, KitapAdi, TurId,YazarId,SayfaSayisi,StokAdeti,ResimLink,SilindiMi) 
values (GETDATE(),'Deneme 503',1,1,1,1,'',0)

select * from Kitaplar where Id = 68
--20220114
--update TabloAdı set Kolon1 = YeniDegeri1, Kolon2 = YeniDegeri2 ...
--where koşul
update Kitaplar set KayitTarihi ='2022-01-12 00:00:00:000',SilindiMi=1
where Id = 67


insert into Kitaplar (KayitTarihi, KitapAdi, TurId,YazarId,SayfaSayisi,StokAdeti,ResimLink,SilindiMi) 
values ('2022-01-15 00:00:00:000','Kaan Deneme 503',1,1,1,1,'',0)

insert into Kitaplar (KayitTarihi, KitapAdi, TurId,YazarId,SayfaSayisi,StokAdeti,ResimLink,SilindiMi) 
values ('2022-01-15','Kaan Deneme 503',1,1,1,1,'',0) --saati kendisi otomatik atar 00 olarak


--2022'den önceki yıldaki tüm kitapları stok 0 ve silindiMi 1 yapalım

select * from Kitaplar (nolock) k
where k.KayitTarihi < '20220101'

select * INTO Kitaplar20230321
From Kitaplar

update Kitaplar set StokAdeti = 0, SilindiMi =1
where KayitTarihi <'20220101'

--4)Listesel Sorgulama(in)
select * from Kitaplar (nolock) k
where k.TurId = 8 or k.TurId = 6;

select * from Kitaplar (nolock) k
where k.TurId in (8,6,2,4)

select * from Kitaplar (nolock) k
where k.KitapAdi in ('Camdaki Kız', 'Hayata Dön')

select * from Kitaplar (nolock) k
where k.KayitTarihi in ('20220114', '20220115', '2022-01-14 14:42:35.603') --= anlamında aslında. Eşittir gibi davranıyor

--5)Like komutu
-- % işareti herhangi bir karakter anlamına gelir
-- _ alt tire işareti bir karakter anlamına gelir 

select * from Kitaplar (nolock) k
where k.KitapAdi like 'C%' --> C ile başlayan kitaplar. c de yazsaydık olurdu

--c ile vaşlasın içinde r olsun
select * from Kitaplar (nolock) k
where k.KitapAdi like 'c%r%' --> C ile başlayan kitaplar ve içinde r de olanlar. Eğer sonda % olmasaydı r ile biten derdik

--herhangi bir yerde en yanyana olsun
select * from Kitaplar (nolock) k
where k.KitapAdi like '%en%' 

--ikinci harf R olsun
select * from Kitaplar (nolock) k
where k.KitapAdi like '_r%' 

--ücüncü harf R olsun
select * from Kitaplar (nolock) k
where k.KitapAdi like '__r%' 

--R ie biten 
select * from Kitaplar (nolock) k
where k.KitapAdi like '%r' 

--sonu l_r ile bitsin (ler lar lur lür...lxr)
select * from Kitaplar (nolock) k
where k.KitapAdi like '%l_r' 


--sadece 4 harfliler geldi
select * from Kitaplar (nolock) k
where k.KitapAdi like '____' 

--[] Aralık belirtmek için
select * from Kitaplar (nolock) k
where k.KitapAdi like '[a-k]__e_[B-Z]%' -- ilk harfi a ile k arasında olanlar ve ...... demek istedik >>  Deneme 503

--^değili
select * from Kitaplar (nolock) k
where k.KitapAdi like '[^A-k]%' 

select * from Kitaplar (nolock) k
where k.KitapAdi like '[^m]___' 

select * from Kitaplar (nolock) k
where k.KitapAdi like '[^1]___' 

--Not Like kullanımı
select * from Kitaplar (nolock) k
where k.KitapAdi not like 'm%' 

--6) Null verileri sorgulama (is)
select * from Kitaplar (nolock) k
where k.ResimLink is null

--Resmi olmayan kitaplar
select * from Kitaplar (nolock) k
where k.ResimLink is null or k.ResimLink =''

--null olmayan is not null
select * from Kitaplar (nolock) k
where k.ResimLink is not null

--Resmi olan kitaplar
select * from Kitaplar (nolock) k
where k.ResimLink is not null and k.ResimLink<> '' 
---Berk
select * from Kitaplar (nolock) k
where k.ResimLink is not null or not k.ResimLink='' 

insert into Kitaplar (KayitTarihi, KitapAdi, TurId, YazarId, SayfaSayisi, StokAdeti, ResimLink, SilindiMi) 
values (getdate(),'Berk Deneme 503',1,1,1,1,null,0 )

--distinct komutu
--Sorgu sonucunda gelen kolonun içinde aynı değerler
--tekrar etmesin istersek o kolonun önüne tekilleştirme anlamına distinct komutunu ekleriz

select distinct TurId from Kitaplar (nolock)
select distinct TurId, SayfaSayisi from Kitaplar (nolock)
select distinct TurId,  YazarId
from Kitaplar (nolock)

--group by da bu soruyu çözeceğiz.
--Kitaplar tablosunda yazarın kaç adet kitabı var?
-------------------------------------------------------------------------
----------------------------JOIN İşlemleri-------------------------------Denormalizasyon yapmıiş oluruz
--Join birleştirmek anlamına gelir
--En az 2 tablonun birleştirilmesi için kullanılır.
--Join Çeşitleri--
--inner join (kesişim)
--left join (soldan)
--right (sağdan)
--outter(dış) join
--cross join(kartezyen)
--self join(joinin aynı tablolar üzerinde yapılmış haline verilen isim)
--composite join
------------------------------------------------------------------------
--inner join (kesişim)

select * from Kitaplar k (nolock)
inner join Turler (nolock) 
on TurId = Turler.Id 

select * from Kitaplar k (nolock)
inner join Turler t (nolock) 
on k.TurId = t.Id -- hangi alanlar üzerinde eşleşme yapılacak

select k.KitapAdi, k.SayfaSayisi,t.TurAdi from 
Kitaplar k (nolock) --table 1
inner join Turler t (nolock)  --table2
on k.TurId = t.Id -- kesişim sağlanacak kolon

--Bir kitabın adı, türü, yazarın adı soyadı
select k.KitapAdi, t.TurAdi, y.YazarAdi + ' ' + y.YazarSoyadi as Yazar
from Kitaplar k (nolock)
inner join Turler t (nolock) on t.Id = k.TurId
join Yazarlar Y (NOLOCK) on k.YazarId = y.Id
where k.SayfaSayisi > 300 and t.TurAdi like '%a%'

-- left join 
-- Kitapların ödünç alınma durumu

select * from Kitaplar k (nolock)  -- table 1
 join OduncIslemler oi (nolock)  -- table 2
on k.Id=oi.KitapId


select * from OduncIslemler
--53 camdaki -- 2 şeker 

insert into OduncIslemler (KayitTarihi, KitapId, OduncAlinmaTarihi, OduncBitisTarihi, PersonelId, TeslimEttigiTarih, TeslimEttiMi, UyeId) values 
(getdate(), 53, getdate(), '2023-04-21 13:50:58.903',1,null,0,5),
(getdate(), 2, getdate(), '2023-05-21 13:50:58.903',1,null,0,2)

--ÖRN: Hiç ödünç alınmamış kitaplar
--1) from 2) join 3) Where 4) group by 5) -----
select k.KitapAdi from Kitaplar k (nolock)
left join OduncIslemler oi (nolock) on oi.KitapId = k.Id
where oi.Id is null




