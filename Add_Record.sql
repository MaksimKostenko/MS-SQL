USE Hotel;
GO
CREATE TRIGGER ADDRecord
ON AccountingOfCustomers FOR INSERT
AS
IF EXISTS (SELECT R.NumberOfRoom,COUNT (IDClient) QuantityOfClients
 	     FROM Room R,AccountingOfCustomers A
     WHERE A.IDRoom = R.IDRoom
 	     GROUP BY R.NumberOfRoom,NumberOfPlaces
 	     HAVING  COUNT (IDClient) > NumberOfPlaces)
BEGIN
RAISERROR('Room is already filled!',16,1)
ROLLBACK TRAN
END
GO
CREATE TRIGGER CheckGender
ON AccountingOfCustomers FOR INSERT
AS
IF EXISTS (SELECT Surname,Name, Middlename
FROM Room R,AccountingOfCustomers A,TypeOfRoom T,Client C 
WHERE A.IDRoom = R.IDRoom AND A.IDClient = C.IDClient AND T.IDGender = R.IDGender AND C.Gender != T.GenderType)
BEGIN
RAISERROR('Uncorrect type of room for this client!',16,1)
ROLLBACK TRAN
END	 

