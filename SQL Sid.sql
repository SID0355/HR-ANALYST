use hr_info;

desc hr_1;
desc hr_2;
show tables;
select * from hr_1;
select * from hr_2;

/* 1-- Average Attrition Rate for All Department -- */
select Department, avg(case when attrition = "Yes" then 1 else 0 end) as avg_attrition_rate
from hr_1
group by Department;


/*  2-- Average Hourly Rate for Male Research Scientist --*/
SELECT JobRole,Gender, AVG(HourlyRate) AS Avg_Hourly_Rate
FROM hr_1
WHERE JobRole = 'Research Scientist' or Gender = 'Male'
group by JobRole,Gender;	




/* 3-- AttritionRate VS MonthlyIncomeStats--*/
select hr_1.Attrition,
avg(hr_2.monthlyincome)as avg_income,
min(hr_2.monthlyincome)as min_income,
max(hr_2.monthlyincome),
stddev(hr_2.monthlyincome)as income_stddev
from hr_1 join hr_2
on hr_1.EmployeeID=hr_2.EmployeeID
group by hr_1.attrition;



/* 4-- Average Working Years for Each Department -- */
select hr_1.department, avg(hr_2.totalworkingyears)as avg_working_year
from hr_1 join hr_2 on hr_1.EmployeeID=hr_2.EmployeeID
group by department;



/* 5-- Job Role VS Work Life Balance -- */
select hr_1.JobRole,sum(hr_2.WorkLifeBalance)as Work_Life_Balance
from hr_1 join hr_2 on hr_1.EmployeeID=hr_2.EmployeeID
group by JobRole;




/* 6-- Attrition Rate Vs Year Since Last Promotion Relation---*/

SELECT hr_1_alias.JobRole, -- Replace hr_1 with hr_1_alias
CONCAT(FORMAT(AVG(hr_1_alias.attrition_rate) * 100, 2), '%') AS Average_Attrition_Rate, -- Replace hr_1 with hr_1_alias
FORMAT(AVG(hr_2.YearsSinceLastPromotion), 2) AS Average_YearsSinceLastPromotion
FROM
  ( SELECT JobRole,attrition,EmployeeID,
CASE WHEN attrition = 'yes' THEN 1 ELSE 0 END AS attrition_rate
    FROM hr_1) AS hr_1_alias
JOIN hr_2 ON hr_1_alias.EmployeeID = hr_2.EmployeeID
GROUP BY hr_1_alias.JobRole
LIMIT 0, 500;










