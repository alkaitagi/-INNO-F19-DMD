SELECT
    DISTINCT employee.name,
    employee.surname,
    employee.ssn
from
    attends,
    employee
where
    attends.employee_ssn = { ARG0 }
    and attends.patient_ssn = 103
    and (
        (
            employee.name LIKE 'K%'
            or employee.name LIKE 'C%'
        ) <> (
            employee.surname LIKE 'L%'
            or employee.surname LIKE 'M%'
        )
    )