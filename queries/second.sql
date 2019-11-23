SELECT employee_ssn, 
       Extract(year FROM date)  AS Year, 
       Extract(month FROM date) AS Month, 
       Extract(hour FROM date)  AS Hour, 
       Count(DISTINCT cost)     AS "Total" 
FROM   attends 
GROUP  BY employee_ssn, 
          year, 
          month, 
          hour; 

SELECT employee_ssn, 
       year, 
       month, 
       hour, 
       TRUNC(Avg(appointments), 2) AS average
FROM   (SELECT employee_ssn, 
               Extract(year FROM date)  AS Year, 
               Extract(month FROM date) AS Month, 
               Extract(hour FROM date)  AS Hour, 
               Count(DISTINCT cost)     AS appointments 
        FROM   attends 
        GROUP  BY employee_ssn, 
                  year, 
                  month, 
                  hour) Z 
GROUP  BY employee_ssn, 
          year, 
          month, 
          hour 