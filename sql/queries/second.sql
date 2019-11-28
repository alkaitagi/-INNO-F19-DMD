select  employee_ssn, extract(dow from date) as Day, (extract(hour from date)) as Hour, COUNT(*) as Attends
from attends
where (extract(year from date) BETWEEN 2015 and 2016)
GROUP BY employee_ssn,  Day, Hour
ORDER BY employee_ssn, Day, Hour
