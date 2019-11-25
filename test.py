import os
import psycopg2
import inserts

conn = psycopg2.connect(os.environ['DATABASE_URL'], sslmode='require')

cur = conn.cursor()
#cur.execute("INSERT INTO PATIENT VALUES (105, 'Ivan', 'Abramov', 'male', 55, '2000-04-23', 165, 'AB+', '+79216864792', 'Russia', 'Cherepovets', 'Luibetskaya', 6, 4);")
cur.execute("INSERT INTO ATTENDS VALUES (1, 105, 1000, 'Description', '2015-06-06 22:41:22');")

conn.commit()