SELECT patient.name,
       patient.surname,
       patient_ssn
FROM patient,

  (SELECT ssn AS patient_ssn
   FROM patient
   EXCEPT (
              (SELECT ssn AS patient_ssn
               FROM patient
               EXCEPT SELECT patient_ssn
               FROM attends
               where Extract(YEAR
                             FROM date) = %(arg0)s
                 AND Extract(MONTH
                             FROM date) = %(arg1)s
               )
            UNION
              (SELECT ssn
               FROM attends,
                    patient
               WHERE attends.patient_ssn=ssn
                 AND Extract(YEAR
                             FROM date) = %(arg0)s
                 AND Extract(MONTH
                             FROM date) = %(arg1)s GROUP  BY ssn
               HAVING COUNT(DISTINCT Extract(WEEK
                                             FROM date))<>5)
            UNION
              (SELECT ssn AS patient_ssn
               FROM attends,
                    patient
               WHERE attends.patient_ssn=ssn
                 AND Extract(YEAR
                             FROM date) = %(arg0)s
                 AND Extract(MONTH
                             FROM date) = %(arg1)s GROUP  BY ssn,
                                                             Extract(WEEK
                                                                     FROM date)
               HAVING Count(*) < 2))) AS T
WHERE patient_ssn = patient.ssn