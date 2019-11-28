select  employee_ssn, extract(dow from date) as Day, (extract(hour from date)) as Hour, COUNT(*) as Total, TRUNC(COUNT(*)/52.0, 5) as Average
from attends
where (extract(year from date) BETWEEN %(arg0)s -  1 and %(arg0)s)
GROUP BY employee_ssn,  Day, Hour
ORDER BY employee_ssn, Day, Hour
