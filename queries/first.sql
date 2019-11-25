SELECT
    DISTINCT employee.name,
    employee.surname,
    employee.ssn
from
    attends,
    employee
where
    attends.employee_ssn = ssn
    and attends.patient_ssn = %(arg0)s
    and (
        (
            employee.name LIKE 'M%%'
            or employee.name LIKE 'L%%'
        ) <> (
            employee.surname LIKE 'M%%'
            or employee.surname LIKE 'L%%'
        )
    )