------------- Data Base Operation DDL ----------------
-- Create Employee database
CREATE DATABASE employee

-- Rename Database
sp_renamedb employee, db_employee

-- Use database
USE db_employee

-- Drop Database
use [master] 
drop Database db_employee

---- Create new Schema 
Create Schema emp

-- drop Schema
drop schema emp

use db_employee

----------------------------------------------------------------------------
----------- Table Operations DDL --------------------------------------------
-- Create Department table
CREATE TABLE Department (
    DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
    DepartmentName_1 VARCHAR(50)
)

-- Rename table name
sp_rename Department, Departments

-- Drop table
Drop table Departments
----------------------------------------------------------------------------

-------- Columns Operation DDL --------------------------------------------
-- add new column
alter table Departments add created_at datetime null


-- Rename Column name
sp_rename 'Departments.DepartmentName_1', DepartmentName

-- alter column datatype/length
alter table Departments alter column DepartmentName Nvarchar(255) null

-- Drop Column
alter table Departments drop column created_at

------------------------------------------------------------------------------

--------------------------------- Insert data DML ----------------------------
-- Insert data into Departments table
INSERT INTO Departments (DepartmentName)
VALUES
('HR'),
('Finance'),
('Engineering'),
('Sales'),
('Marketing'),
('IT'),
('Operations'),
('Customer Service'),
('Research and Department'),
('Legal'),
('Quality Assurance')

select * from Departments
--------------------------------------------------------------------------------

-- Create Employee table
CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NULL,
    LastName VARCHAR(50) NULL,
    DateOfBirth DATE NULL,
    Gender VARCHAR(10) NULL,
    DepartmentID INT NULL,
    Salary FLOAT NULL,
    HireDate DATE NULL,
	Created_at DATETIME
)

-- Insert data into Employees table
INSERT INTO Employees
(FirstName, LastName, DateOfBirth, Gender, DepartmentID, Salary, HireDate,Created_at)
VALUES
('John', 'Smith', '1980-05-15', 'Male', 3, 60000.00, '2020-01-15',GETDATE()),
('Sarah', 'Johnson', '1990-07-20', 'Female', 2, 55000.00, '2019-08-10',GETDATE()),
('Michael', 'Williams', '1985-02-10', 'Male', 3, 62000.00, '2021-03-22',GETDATE()),
('Emily', 'Brown', '1992-11-30', 'Female', 4, 58000.00, '2022-05-18',GETDATE()),
('David', 'Jones', '1988-09-05', 'Male', 5, 65000.00, '2018-12-01',GETDATE()),
('Olivia', 'Davis', '1995-04-12', 'Female', 2, 54000.00, '2023-02-10',GETDATE()),
('James', 'Wilson', '1983-03-25', 'Male', 6, 70000.00, '2017-07-15',GETDATE()),
('Sophia', 'Anderson', '1991-08-17', 'Female', 4, 59000.00, '2019-10-30',GETDATE()),
('Liam', 'Miller', '1979-12-01', 'Male', 3, 61000.00, '2020-11-05',GETDATE()),
('Emma', 'Taylor', '1993-06-28', 'Female', 5, 63000.00, '2022-04-02',GETDATE()),
('Robert', 'Johnson', '1982-09-14', 'Male', 4, 58000.00, '2020-06-15',GETDATE()),
('Mia', 'Moore', '1987-03-03', 'Female', 5, 67000.00, '2019-05-10',GETDATE()),
('William', 'Clark', '1984-04-20', 'Male', 3, 61000.00, '2022-09-12',GETDATE()),
('Charlotte', 'Anderson', '1994-01-07', 'Female', 2, 55000.00, '2019-11-28',GETDATE()),
('Daniel', 'Davis', '1989-08-25', 'Male', 4, 59000.00, '2020-08-03',GETDATE()),
('Sophia', 'Turner', '1990-12-12', 'Female', 5, 64000.00, '2018-10-15',GETDATE()),
('Matthew', 'Parker', '1986-06-08', 'Male', 6, 66000.00, '2022-02-20',GETDATE()),
('Anita', 'Parker', '1999-06-08', 'Female', 13, 48000.00, '2022-02-20',GETDATE()),
('Matthew', 'Smith', '1976-09-09', 'Male', 15, 96000.00, '2022-02-20',GETDATE()),
('Andro', 'Parker', '1986-06-25', 'Male', 16, 80000.00, '2022-02-20',GETDATE()),
('Sara', 'Devis', '1991-02-12', 'Male', 20, 25000.00, '2022-02-20',GETDATE()),
('Ava', 'Williams', '1993-03-15', 'Female', 2, 70000.00, '2021-04-10',GETDATE())

-- Selecting all employees and departments table
SELECT * FROM Employees
SELECT * FROM Departments

----------------------------- Where Conditions (filter) --------------------------------------
----- apply filter with Comparison Operators =,<>,<,>,<=,>=
SELECT * FROM Employees WHERE DepartmentID = 3

SELECT * FROM Employees WHERE DepartmentID <> 3

--- using <,>,<=,>=
select * from Employees where Salary > 60000
select * from Employees where Salary <= 60000


-------------- Multiple Filter or where conditions with Logical Opertor ---------------------------
------ And Opertor
SELECT * FROM Employees WHERE DepartmentID = 3 and Salary > 61000

--- Or Opertor
SELECT * FROM Employees WHERE DepartmentID = 3 or Salary > 61000

--- Between Opertor  yyyy-mm-dd  ---> dd/mm/yy 
select * from Employees where cast(HireDate as data) between '2019-08-01'  and '2020-01-01'

select * from Employees where Salary between 50000  and 60000

-- In Opertor
SELECT * FROM Employees WHERE DepartmentID in (3,4,7)

-- Not In Operator
SELECT * FROM Employees WHERE DepartmentID not in (3,4)

-- like Operator 
SELECT * FROM Employees WHERE FirstName like ('%V%') 

-- ALL Operator
select * from Employees where 
DepartmentID = ALL (select DepartmentID from Departments where DepartmentID = 3)

-- ANY Operator
select * from Employees where 
DepartmentID = any (select DepartmentID from Departments where DepartmentID in (3,2))

-- Exists Operator
select * from Employees ep where 
exists (select DepartmentID from Departments dp where ep.DepartmentID=dp.DepartmentID and DepartmentID in (4))

-------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------- JOINS ------------------------------------------------------------------------------------------------------------
-- Finding employees by department name
SELECT ep.*,dp.departmentname as 'dpt_name'
FROM Employees ep
INNER JOIN Departments dp ON ep.DepartmentID = dp.DepartmentID
--WHERE dp.DepartmentName in ('IT','HR')

-- Left Join Selecting all data from employees and departments table
SELECT ep.*,dp.DepartmentName FROM Employees ep
LEFT JOIN Departments dp ON ep.DepartmentID = dp.DepartmentID

-- Right Join Selecting all data from employees and departments table
SELECT dp.DepartmentName, ep.* FROM Employees ep
Right JOIN Departments dp ON ep.DepartmentID = dp.DepartmentID

-- Full Outer Join Selecting all data from employees and departments table
SELECT dp.DepartmentName, ep.* FROM Employees ep
FULL outer JOIN Departments dp ON ep.DepartmentID = dp.DepartmentID
--------------------------------------------------------------------------------------------------------------------------------------------------------

-- Average Salary

update Employees
set [FirstName] = [FirstName] +' ' + LastName
where [FirstName] = 'vijay'

select * from Employees


select distinct  Gender,
case
when Gender = 'Male' then '0'
else '1'
END as 'revalue'
from Employees