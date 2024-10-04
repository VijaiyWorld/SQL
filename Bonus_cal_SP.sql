
----------
--CREATE PROCEDURE Bonus_cal
--AS
---- Qry Procedure
--GO

use db_employee

exec Bonus_cal

alter PROCEDURE Bonus_cal
AS
--
IF OBJECT_ID('TEMPDB..emp_exp', 'U') IS NOT NULL 
  DROP TABLE TEMPDB..emp_exp;

CREATE TABLE tempdb..emp_exp (
    EmployeeID INT,
    FirstName VARCHAR(50) NULL,
    LastName VARCHAR(50) NULL,
    DateOfBirth DATE NULL,
    Gender VARCHAR(10) NULL,
    DepartmentID INT NULL,
    Salary FLOAT NULL,
    HireDate DATE NULL,
	work_exp float null,
	Points float null
)

insert into tempdb..emp_exp
select EmployeeID,FirstName,LastName,DateOfBirth,Gender,DepartmentID,Salary,HireDate,
(year(GETDATE()) - year(HireDate)) as 'work_exp',
CASE
When Gender = 'Female' and (year(GETDATE()) - year(HireDate)) > 2 then 10 
When Gender = 'Male' and (year(GETDATE()) - year(HireDate)) > 5 then 10
Else 5
End as 'Points'
from Employees

--insert into db_employee.dbo.tbl_bonus 
--select EmployeeID,year(getutcdate()), Salary, Points, salary + (500 * points) as 'Bonus' from tempdb..emp_exp

-- Merge update --------
MERGE INTO db_employee.dbo.tbl_bonus tg 
USING tempdb..emp_exp sr
ON year(getutcdate()) = tg.bonus_year and sr.EmployeeID = tg.EmployeeID
WHEN MATCHED THEN
   UPDATE SET tg.bonus = sr.salary + (500 * sr.points),
			  tg.Points = sr.Points,
			  tg.Salary = sr.Salary
			  
WHEN NOT MATCHED THEN
   Insert  values (sr.EmployeeID,year(getutcdate()), sr.Salary, sr.Points, sr.salary + (500 * sr.points));

drop table tempdb..emp_exp

GO

drop table tbl_bonus
CREATE TABLE tbl_bonus (
    EmployeeID INT,
    bonus_year VARCHAR(50) NULL,
    Salary VARCHAR(50) NULL,
    Points varchar(50) NULL,
	bonus float null
)


select * from tbl_bonus