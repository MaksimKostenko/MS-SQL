/*Зміна номера, в якому зупинився постоялець*/
 CREATE TRIGGER UpdateRoom
 ON AccountingOfCustomers
 FOR UPDATE
 AS
IF EXISTS (SELECT  I.IDRoom,D.IDRoom FROM INSERTED I , DELETED D WHERE I.IDRoom = D.IDRoom OR I.IDRoom < 1)
BEGIN
 RAISERROR('Data must be changed!',16,1)
 ROLLBACK TRAN
 END
 UPDATE AccountingOfCustomers SET IDRoom = 9 WHERE IDRoom = 9
 /*Зміна дати виселення.*/
 GO
 CREATE TRIGGER UpdateDate
 ON AccountingOfCustomers
 FOR UPDATE
 AS
 IF EXISTS (SELECT  I.DateOfLeaving,D.DateOfLeaving FROM INSERTED I , DELETED D 
 WHERE I.DateOfLeaving = D.DateOfLeaving OR I.DateOfLeaving < GETDATE())
 BEGIN
 RAISERROR('Uncorrect data!',16,1)
 ROLLBACK TRAN
 END
 UPDATE AccountingOfCustomers SET DateOfLeaving ='16.12.15' WHERE DateOfLeaving ='16.12.15'
