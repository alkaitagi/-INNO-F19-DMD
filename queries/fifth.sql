select ssn as employee_ssn
from employee
EXCEPT
(
(SELECT ssn
FROM  attends, employee
WHERE attends.employee_ssn=ssn and date > %(arg0)s
GROUP  BY ssn
HAVING
COUNT(DISTINCT Extract(year FROM date))<>10)

UNION

(SELECT ssn as employee_ssn
FROM   attends, employee
WHERE attends.employee_ssn=ssn and date > %(arg0)s
GROUP  BY ssn,
          Extract(year FROM date)
HAVING Count(*) < 5)

UNION

(SELECT ssn as employee_ssn
FROM   attends, employee
WHERE attends.employee_ssn=ssn and date > '1-1-2010'
GROUP  BY ssn
HAVING COUNT(DISTINCT patient_ssn)<100)
)