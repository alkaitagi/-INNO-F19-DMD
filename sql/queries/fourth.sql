SELECT sum(
CASE
    WHEN Age < 50 AND ATTENDS < 3 THEN Attends * 200
    WHEN Age < 50 AND ATTENDS >= 3 THEN Attends * 250
    WHEN Age >= 50 AND ATTENDS < 3 THEN Attends * 400
    WHEN Age >= 50 AND ATTENDS >= 3 THEN Attends * 500
END) from
(select patient.ssn, date_part('year', AGE(birth_date)) as Age, extract(month from date) as Month, COUNT(*) as Attends
from patient, attends
where patient.ssn = attends.patient_ssn and extract(year from date) = %(arg0)s and extract(month from date) = %(arg1)s
GROUP BY patient.ssn, Month) as t