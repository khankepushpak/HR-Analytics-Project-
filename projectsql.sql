create database HRAnalytics;
use HRAnalytics;
select * FROM hr_1;
select * FROM hr_2;

---------##KPI'S- 1##---------

## Date of Joining
alter table hr_2
add column date_of_joining date;

alter table hr_2
drop date_of_joining;

ALTER TABLE hranalytics.hr_2
ADD COLUMN Date_of_Joining DATE;

UPDATE hranalytics.hr_2
SET Date_of_Joining = CONCAT(year_of_joining, '-', LPAD(month_of_joining, 2, '0'), '-', LPAD(day_of_joining, 2, '0'));
set sql_safe_updates=0;

## YEAR


---------##KPI'S- 2##---------

##Average Attrition rate for all Departments
select department,avg(
case when Attrition ='yes'
then 1 else 0 
end) as averae_attrition_rate
from hr_1
group by Department;

##Average Hourly rate of Male Research Scientist
SELECT 
    JobRole, AVG(HourlyRate) AS avg_hr_rate, Gender
FROM
    hr_1
WHERE JobRole = "Research Scientist" and Gender ="Male"
group by JobRole, Gender;

##Attrition rate Vs Monthly income stats
select hr_1.EmployeeNumber, hr_1.Attrition, hr_1.Department, hr_1.JobRole, hr_2.MonthlyIncome from hr_1 inner join hr_2
on hr_1.EmployeeNumber = hr_2.Employee_ID
where Attrition ="yes";

##Average working years for each Department
select hr_1.Department, avg(hr_2.TotalWorkingYears) as AVG_Working_Yr from hr_1 inner join hr_2
on hr_1.EmployeeNumber = hr_2.Employee_ID 
group by hr_1.Department;

##Departmentwise No of Employees
select hr_1.Department, sum(hr_1.EmployeeCount) as No_of_Employees 
from hr_1
group by Department;

##Count of Employees based on Educational Fields
select hr_1.EducationField, sum(hr_1.EmployeeCount) as Count_of_Employees 
from hr_1
group by EducationField;

##Job Role Vs Work life balance
select hr_1.EmployeeNumber, hr_1.JobRole, hr_2.WorkLifeBalance from hr_1 inner join hr_2
on hr_1.EmployeeNumber = hr_2.Employee_ID;

##Attrition rate Vs Year since last promotion relation
select hr_1.Department, count(
case when Attrition = "yes"
then 1 else 0
End )
as Count_of_attrition_rate, avg(hr_2.YearsSinceLastPromotion) as avg_since_promotion
from hr_1 inner join hr_2
on hr_1.EmployeeNumber = hr_2.Employee_ID 
group by hr_1.Department;

##Gender based Percentage of Employee
select Gender, (sum(hr_1.EmployeeCount)*2)/1000  as percent_of_emp from hr_1
group by Gender;


##Deptarment / Job Role wise job satisfactio
select hr_1.Department, hr_1.JobRole, hr_1.JobSatisfaction from hr_1;
