select employee_ssn,
       extract(year from date) as Year,
       extract(month from date) as Month,
       extract(hour from date) as Hour,
       count(DISTINCT cost) as "Total"
from attends
group by employee_ssn, Year, Month, Hour;



select employee_ssn,
Year, Month, Hour,
AVG(appointments) as average from
(
  select employee_ssn,
       extract(year from date) as Year,
       extract(month from date) as Month,
       extract(hour from date) as Hour,
       count(DISTINCT cost) as appointments
from attends
group by employee_ssn, Year, Month, Hour
) Z
group by employee_ssn, Year, Month, Hour