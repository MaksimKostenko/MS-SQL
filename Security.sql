USE Hotel;
CREATE LOGIN Maksim WITH PASSWORD ='qwerty';
CREATE USER Maksim FOR LOGIN Maksim;

CREATE LOGIN Bill WITH PASSWORD ='qwerty1';
CREATE USER Bill FOR LOGIN Bill;

CREATE LOGIN John WITH PASSWORD ='qwerty2';
CREATE USER John FOR LOGIN John;

EXECUTE sp_addrolemember db_datareader, Maksim;

GRANT EXEC ON dbo.LivingNow TO Bill;

REVOKE ALL 
ON dbo.Client TO John;

/*Encription*/
-- Створення мастер-ключа 
GO
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '7879';
GO
-- Створення сертифікату
CREATE CERTIFICATE my_sertificate
WITH SUBJECT = 'Sensitive Data';
GO
-- Створення симетричного ключа
CREATE SYMMETRIC KEY my_symmetric_key 
WITH ALGORITHM = AES_128 
ENCRYPTION BY CERTIFICATE my_sertificate;
GO
-- Зміна схеми даних
ALTER TABLE dbo.Client 
ADD Surname_encrypt varbinary(MAX) NULL
GO
-- Шифрування колонки таблиці
-- Opens the symmetric key for use
OPEN SYMMETRIC KEY my_symmetric_key
DECRYPTION BY CERTIFICATE my_sertificate;
GO
UPDATE dbo.Client
SET Surname_encrypt = EncryptByKey (Key_GUID('my_symmetric_key'),Surname)
FROM dbo.Client;
GO
-- Closes the symmetric key
CLOSE SYMMETRIC KEY my_symmetric_key;
GO


select * from dbo.Client;
UPDATE dbo.Client
set Gender = 'Female' where idClient ='10';