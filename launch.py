import os
import psycopg2

conn = psycopg2.connect(os.environ['DATABASE_URL'], sslmode='require')

cur = conn.cursor()
# cur.execute('''CREATE TABLE STUDENT
#       (ADMISSION INT PRIMARY KEY     NOT NULL,
#       NAME           TEXT    NOT NULL,
#       AGE            INT     NOT NULL,
#       COURSE        CHAR(50),
#       DEPARTMENT        CHAR(50));''')

cur.execute("select * from student")

conn.commit()
conn.close()

# cur.execute(
#     "INSERT INTO STUDENT (ADMISSION,NAME,AGE,COURSE,DEPARTMENT) VALUES (3421, 'Joel', 17, 'Computer Science', 'ICT')"
# )
# cur.execute(
#     "INSERT INTO STUDENT (ADMISSION,NAME,AGE,COURSE,DEPARTMENT) VALUES (3422, 'Antony', 19, 'Electrical Engineering', 'Engineering')"
# )
# cur.execute(
#     "INSERT INTO STUDENT (ADMISSION,NAME,AGE,COURSE,DEPARTMENT) VALUES (3423, 'Alice', 18, 'Information Technology', 'ICT')"
# )
# cur.execute("UPDATE STUDENT set AGE = 20 where ADMISSION = 3420")
# cur.execute("DELETE from STUDENT where ADMISSION=3420;")
# con.commit()
# print("Record inserted successfully")
# cur = con.cursor()
# cur.execute("SELECT admission, name, age, course, department from STUDENT")
# rows = cur.fetchall()

# print(rows)
# for row in rows:
#     print("ADMISSION =", row[0])
#     print("NAME =", row[1])
#     print("AGE =", row[2])
#     print("COURSE =", row[3])
#     print("DEPARTMENT =", row[4], "\n")
# print("Operation done successfully")
# con.close()