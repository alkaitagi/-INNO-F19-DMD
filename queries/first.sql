SELECT
    DISTINCT employee.name,
    employee.surname,
    employee.ssn
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