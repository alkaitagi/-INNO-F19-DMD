select ssn as patient_ssn
from patient
EXCEPT
(
(SELECT ssn
FROM   attends, patient
WHERE attends.patient_ssn=ssn and  Extract(year FROM date) = %(arg0)s and Extract(month FROM date) = %(arg1)s
GROUP  BY ssn
HAVING
COUNT(DISTINCT Extract(week FROM date))<>5)
UNION
(SELECT ssn as patient_ssn
FROM   attends, patient
WHERE attends.patient_ssn=ssn and  Extract(year FROM date) = %(arg0)s and Extract(month FROM date) = %(arg1)s
GROUP  BY ssn,
          Extract(week FROM date)
HAVING Count(*) < 2))