
--1
CREATE DATABASE PondokPizza ON(
	NAME = PondokPizza,
	FILENAME = 'D:\Database\Quiz\PondokPizza.mdf',
	MAXSIZE = 300MB,
	FILEGROWTH = 30%
)

LOG ON(
	NAME = PondokPizza_log,
	FILENAME = 'D:\Database\Quiz\PondokPizza.ldf',
	MAXSIZE = 300MB,
	FILEGROWTH = 30%
)

USE PondokPizza

--2

--3
ALTER TABLE Menu
DROP COLUMN MenuID

ALTER TABLE Menu
ADD MenuID INT IDENTITY

ALTER TABLE Menu
ALTER COLUMN MenuID INT NOT NULL

ALTER TABLE Menu
ADD PRIMARY KEY (MenuID) 

ALTER TABLE Menu
ALTER COLUMN MenuType VARCHAR(100) NOT NULL

ALTER TABLE Menu
ALTER COLUMN MenuName VARCHAR(100) NOT NULL

ALTER TABLE Menu
ALTER COLUMN MenuDescription VARCHAR(255) NOT NULL

ALTER TABLE Menu
ALTER COLUMN Price INT NOT NULL 

ALTER TABLE Menu
ADD CHECK ((Price) BETWEEN 100000 AND 250000)

--Staff
ALTER TABLE Staff
ALTER COLUMN StaffID INT NOT NULL

ALTER TABLE Staff
ADD PRIMARY KEY (StaffID) 

ALTER TABLE Staff
ALTER COLUMN StaffName VARCHAR(100) NOT NULL

ALTER TABLE Staff
ALTER COLUMN StaffGender CHAR(1) NOT NULL

ALTER TABLE Staff
ADD CHECK (StaffGender LIKE 'M' OR StaffGender LIKE'F')

ALTER TABLE Staff
ALTER COLUMN StaffDOB DATE NOT NULL

ALTER TABLE Staff
ALTER COLUMN StaffPhone CHAR (12) NOT NULL

--tRANSACTION HEADER
ALTER TABLE TransactionHeader
ALTER COLUMN TransactionID INT NOT NULL

ALTER TABLE TransactionHeader
ADD PRIMARY KEY (TransactionID) 

ALTER TABLE TransactionHeader
ALTER COLUMN TransactionDate DATE NOT NULL


--TRANSACTIONDETAIL
ALTER TABLE TransactionDetail
ALTER COLUMN TransactionID INT NOT NULL

ALTER TABLE TransactionDetail
ADD FOREIGN KEY (TransactionID) REFERENCES TransactionHeader(TransactionID)

ALTER TABLE TransactionDetail
ALTER COLUMN MenuID INT NOT NULL

ALTER TABLE TransactionDetail
ADD FOREIGN KEY (MenuID) REFERENCES Menu(MenuID)

ALTER TABLE TransactionDetail
ALTER COLUMN Quantity INT NOT NULL

--4
CREATE LOGIN Pondok WITH PASSWORD = 'Pondok123'
CREATE USER PondokPizza FOR LOGIN Pondok

EXEC sp_addsrvrolemember 'Pondok', 'dbcreator'
EXEC sp_addrolemember 'db_datareader', PondokPizza
EXEC sp_addrolemember 'db_datawriter', PondokPizza

CREATE USER Pizza
WITHOUT LOGIN

EXEC sp_addrolemember 'db_datareader', Pizza

GRANT INSERT 
ON TransactionHeader
TO Pizza

GRANT INSERT 
ON TransactionDetail
TO Pizza



