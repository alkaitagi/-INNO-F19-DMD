SELECT
    DISTINCT employee.name,
    employee.surname,
    employee.ssn
from
    attends,
    employee
where
    attends.employee_ssn = ssn
    and attends.patient_ssn = %(arg0)d
    and (
        (
            employee.name LIKE 'K%'
            or employee.name LIKE 'C%'
        ) <> (
            employee.surname LIKE 'L%'
            or employee.surname LIKE 'M%'
        )
    )