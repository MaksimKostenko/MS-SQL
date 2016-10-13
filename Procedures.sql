/*����������, �� ���������� � ����� �� ����� ���*/
CREATE PROCEDURE LivingNow
AS
SELECT Surname,Name, Middlename,DateOfLeaving
FROM Client C,AccountingOfCustomers A
WHERE C.IDClient=A.IDClient AND DateOfEntry <= GETDATE() AND DateOfLeaving > GETDATE()
GROUP BY Surname,Name, Middlename,DateOfLeaving
EXEC LivingNow
/*"³��� ����": ���� - ����� - �������� ������� ���� � ����� - ������� ������ ����.*/
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
/*- "������� �� ������ ������" (����� ��� ����������� ����������).*/
GO
CREATE PROCEDURE CostOfLeaving
 AS
  SELECT Surname,Name, Middlename,(DATEDIFF ( DAY , DateOfEntry , DateOfLeaving ))*CostOfLivingForDay AS 'CostOfLeaving'
  FROM Client C,AccountingOfCustomers A ,Room R
  WHERE C.IDClient=A.IDClient AND R.IDRoom = A.IDRoom
  EXEC CostOfLeaving
