select ssn as employee_ssn
from employee
EXCEPT
(
(
select ssn as employee_ssn
from employee
EXCEPT
SELECT employee_ssn
FROM  attends
WHERE date > %(arg0)s)

UNION

(SELECT employee_ssn
FROM  attends
WHERE date > %(arg0)s
GROUP  BY employee_ssn
HAVING
COUNT(DISTINCT Extract(year FROM date))<>10)

UNION

(SELECT employee_ssn
FROM   attends
WHERE date > %(arg0)s
GROUP BY employee_ssn,
          Extract(year FROM date)
HAVING Count(*) < 5)

UNION

(SELECT employee_ssn
FROM   attends
WHERE date > %(arg0)s
GROUP BY employee_ssn
HAVING COUNT(DISTINCT patient_ssn)<100)
)
