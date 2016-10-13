USE HOTEL;
SELECT NumberOfRoom,DateOfLeaving FROM Room R,AccountingOfCustomers A
WHERE R.IDRoom = A.IDRoom AND (DateOfLeaving = (SELECT CONVERT (DATE, GETDATE()))
OR DateOfLeaving=(SELECT DATEADD(DAY, DATEDIFF(DAY, '20000101', CURRENT_TIMESTAMP), '20000102')))
GROUP BY NumberOfRoom,DateOfLeaving
GO
SELECT R.NumberOfRoom FROM ROOM R
EXCEPT
SELECT R.NumberOfRoom					
FROM Room R,AccountingOfCustomers A WHERE A.IDRoom = R.IDRoom 
GO
SELECT R.NumberOfRoom,COUNT (IDClient) QuantityOfClients
 FROM Room R,AccountingOfCustomers A
 WHERE A.IDRoom = R.IDRoom
 GROUP BY R.NumberOfRoom,NumberOfPlaces
 HAVING  COUNT (IDClient) = NumberOfPlaces
 GO
SELECT R.NumberOfRoom,COUNT (IDClient) QuantityOfClients 
 FROM Room R,AccountingOfCustomers A
 WHERE A.IDRoom = R.IDRoom
 GROUP BY R.NumberOfRoom,NumberOfPlaces
 HAVING  COUNT (IDClient) < NumberOfPlaces
 /*Перевірити, чи є в наявності вільні номери для жінок (чоловіків)*/
 GO
 SELECT R.NumberOfRoom FROM ROOM R,TypeOfRoom T
 WHERE R.IDGender = T.IDGender AND GenderType = 'Female'
 EXCEPT
 SELECT  R.NumberOfRoom
 FROM Room R, TypeOfRoom T,AccountingOfCustomers A
 WHERE R.IDGender = T.IDGender AND GenderType = 'Female' AND A.IDRoom = R.IDRoom
 GROUP BY R.NumberOfRoom
