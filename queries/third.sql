select ssn as patient_ssn
from patient
EXCEPT
((select ssn as patient_ssn
from patient
EXCEPT
select patient_ssn
from attends)
UNION
(SELECT ssn as patient_ssn
FROM   attends, patient
WHERE attends.patient_ssn=ssn and  Extract(year FROM date) = 2015 and Extract(month FROM date) = 6
GROUP  BY ssn,
          Extract(week FROM date)
HAVING Count(*) < 2))