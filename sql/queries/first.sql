SELECT
    employee.name,
    employee.surname,
    employee.ssn,
	MAX(date) as datee
from
    attends,
    employee,
    patient
where
    attends.employee_ssn = employee.ssn
    and attends.patient_ssn = %(arg0)s
    and (
        (
            employee.name LIKE 'M%%'
            or employee.name LIKE 'L%%'
        ) <> (
            employee.surname LIKE 'M%%'
            or employee.surname LIKE 'L%%'
        ) and patient.ssn = attends.patient_ssn
        and patient.gender = 'female' and
        employee.type = 'doctor'
    )
GROUP BY employee.ssn
HAVING to_char(MAX(date), 'yyyy-mm-dd')=to_char((SELECT
    MAX(date)
from
    attends,
    employee,
    patient
where
    attends.employee_ssn = employee.ssn
    and attends.patient_ssn = %(arg0)s
    and (
        (
            employee.name LIKE 'M%%'
            or employee.name LIKE 'L%%'
        ) <> (
            employee.surname LIKE 'M%%'
            or employee.surname LIKE 'L%%'
        ) and patient.ssn = attends.patient_ssn
        and patient.gender = 'female' and
        employee.type = 'doctor'
    )), 'yyyy-mm-dd')