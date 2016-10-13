CREATE TABLE TypeOfRoom
	(IDGender INT IDENTITY CONSTRAINT GenderPrimary PRIMARY KEY,
	 GenderType VARCHAR(10))

CREATE TABLE ClassOfRoom
	(IDClass INT IDENTITY CONSTRAINT ClassPrimary PRIMARY KEY,
	 NameOfClass VARCHAR(10))

CREATE TABLE Client
	(IDClient INT IDENTITY CONSTRAINT ClientPrimary PRIMARY KEY,
	 Surname VARCHAR(20) NOT NULL 
		CONSTRAINT SurnameStudentCheck CHECK (Surname NOT LIKE '%[^a-z][0-9]%'),
	 Name VARCHAR(20) NOT NULL 
		CONSTRAINT NameStudentCheck CHECK (Name NOT LIKE '%[^a-z][0-9]%'), 
	 Middlename VARCHAR(20) NOT NULL 
		CONSTRAINT MiddlenameStudentCheck CHECK (Middlename NOT LIKE '%[^a-z][0-9]%'),
	 Gender VARCHAR(10))
CREATE TABLE Room
	(IDRoom INT IDENTITY CONSTRAINT RoomPrimary PRIMARY KEY,
	 NumberOfRoom INT,
	 NumberOfPlaces INT,
	 CostOfLivingForDay MONEY,
	 IDClass INT,
		CONSTRAINT RoomClass FOREIGN KEY (IDClass) REFERENCES ClassOfRoom,
	 IDGender INT,
		CONSTRAINT RoomForSomeGenderType FOREIGN KEY (IDGender) REFERENCES TypeOfRoom)

CREATE TABLE AccountingOfCustomers
	(IDRecord INT IDENTITY CONSTRAINT RecordPrimary PRIMARY KEY,
	 IDRoom INT,
		CONSTRAINT RoomOfClient FOREIGN KEY (IDRoom) REFERENCES Room,
	 IDClient INT,
		CONSTRAINT Clients FOREIGN KEY (IDClient) REFERENCES Client,
	 DateOfEntry date,
	 DateOfLeaving date,
	 CostOfLiving MONEY)
