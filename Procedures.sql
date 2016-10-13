/*Постояльці, які проживають у готелі на даний час*/
CREATE PROCEDURE LivingNow
AS
SELECT Surname,Name, Middlename,DateOfLeaving
FROM Client C,AccountingOfCustomers A
WHERE C.IDClient=A.IDClient AND DateOfEntry <= GETDATE() AND DateOfLeaving > GETDATE()
GROUP BY Surname,Name, Middlename,DateOfLeaving
EXEC LivingNow
/*"Вільні місця": клас - номер - загальна кількість місць в номері - кількість вільних місць.*/
GO
CREATE PROCEDURE FreePlaces
AS
 SELECT NameOfClass,NumberOfRoom,NumberOfPlaces, NumberOfPlaces - COUNT (IDClient) NumberOfFreePlaces
 FROM Room R LEFT JOIN AccountingOfCustomers A  ON A.IDRoom = R.IDRoom
 INNER JOIN ClassOfRoom C ON  R.IDClass = C.IDClass
 WHERE  (SELECT COUNT (A1.IDClient) QuantityOfClients1
	   FROM Room R1,AccountingOfCustomers A1
	   WHERE A1.IDRoom = R1.IDRoom) IS NOT NULL					
 GROUP BY NameOfClass,NumberOfRoom,NumberOfPlaces
 ORDER BY NameOfClass,NumberOfRoom
 EXEC FreePlaces
/*- "Рахунок на оплату номера" (запит для конкретного постояльця).*/
GO
CREATE PROCEDURE CostOfLeaving
 AS
  SELECT Surname,Name, Middlename,(DATEDIFF ( DAY , DateOfEntry , DateOfLeaving ))*CostOfLivingForDay AS 'CostOfLeaving'
  FROM Client C,AccountingOfCustomers A ,Room R
  WHERE C.IDClient=A.IDClient AND R.IDRoom = A.IDRoom
  EXEC CostOfLeaving
