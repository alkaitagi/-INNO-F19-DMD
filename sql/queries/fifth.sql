select employee.name, employee.surname, employee.ssn
from
employee,
(SELECT ssn AS employee_ssn
FROM employee
EXCEPT (
          (SELECT ssn AS employee_ssn
           FROM employee
           EXCEPT SELECT employee_ssn
           FROM attends
           WHERE (EXTRACT (YEAR
                           FROM date) BETWEEN %(arg0)s - 9 AND %(arg0)s))
        UNION
          (SELECT employee_ssn
           FROM attends
           WHERE (EXTRACT (YEAR
                           FROM date) BETWEEN %(arg0)s - 9 AND %(arg0)s) GROUP  BY employee_ssn
           HAVING COUNT(DISTINCT Extract(YEAR
                                         FROM date))<>10)
        UNION
          (SELECT employee_ssn
           FROM attends
           WHERE (EXTRACT (YEAR
                           FROM date) BETWEEN %(arg0)s - 9 AND %(arg0)s)
           GROUP BY employee_ssn,
                    Extract(YEAR
                            FROM date)
           HAVING Count(*) < 5)
        UNION
          (SELECT employee_ssn
           FROM attends
           WHERE (EXTRACT (YEAR
                           FROM date) BETWEEN %(arg0)s - 9 AND %(arg0)s)
           GROUP BY employee_ssn
           HAVING COUNT(DISTINCT patient_ssn) < 100))) as T
where employee_ssn = employee.ssn