import random
import datetime
import radar
import string
import json

with open('json/samples.json') as file:
    samples = json.load(file)


def randomString(n):
    # n - length of a string to be generated

    letters = string.ascii_lowercase
    return ''.join(random.choice(letters) for i in range(n))


def finalizeSql(sql):
    return '{};\n'.format(sql[:-2])


def insert_uses(inventory_items, treatment_plans):
    # inventory_items - available inventory items ids
    # treatment_plans - available trearment plans ids

    sql = "INSERT INTO Uses (inventory_id, treatment_id) VALUES\n "

    random.shuffle(inventory_items)
    random.shuffle(treatment_plans)
    n = min(len(inventory_items), len(treatment_plans))

    for i in range(n):
        sql += "({}, {}),\n".format(inventory_items[i], treatment_plans[i])

    return finalizeSql(sql)


def insert_chats(n, employees, patients):
    # n - number of chats
    # employees - available employee ssns
    # patients - available patient ssns

    sql = "INSERT INTO Chat (message_id, time, employee_ssn, patient_ssn, text) VALUES\n "

    for i in range(n):
        sql += "('{}', '{}', {}, {}, '{}'),\n".format(
            randomString(50),
            radar.random_datetime(start=datetime.datetime(year=2015,
                                                          month=5,
                                                          day=24),
                                  stop=datetime.datetime(year=2019,
                                                         month=5,
                                                         day=24)),
            random.choice(employees), random.choice(patients),
            "Random message")

    return finalizeSql(sql)


def insert_attends(n, employees, patients):
    # n - number of attends
    # employees - available employee ssns
    # patients - available patient ssns

    sql = "INSERT INTO Attends (employee_ssn, patient_ssn, cost, description, date) VALUES\n "

    for i in range(n):
        sql += "({}, {}, {}, '{}', '{}'),\n".format(
            random.choice(employees), random.choice(patients),
            random.randint(1000, 50000), "Attend description",
            radar.random_date(start=datetime.datetime(year=2010,
                                                      month=5,
                                                      day=24),
                              stop=datetime.datetime(year=2019,
                                                     month=11,
                                                     day=27)))

    return finalizeSql(sql)


def insert_prescribes(n, employees, patients):
    # n - number of prescribes
    # employees - available employee ssns
    # patients - available patient ssns

    sql = "INSERT INTO Prescribe (employee_ssn, patient_ssn, description, date) VALUES\n "

    for i in range(n):
        sql += "({}, {}, '{}', '{}'),\n".format(
            random.choice(employees), random.choice(patients),
            "Doctor attends patient",
            radar.random_date(start=datetime.date(year=2015, month=5, day=24),
                              stop=datetime.date(year=2019, month=5, day=24)))

    return finalizeSql(sql)


def insert_analysis_results(analyzes, patients):
    # analyzes - available analyzes ids
    # patients - available patient ssns

    sql = "INSERT INTO Analysis_result (id, patient_ssn, type, result, date) VALUES\n "

    analysis_types = samples["analysis_types"]

    for i in analyzes:
        sql += "({}, {}, '{}', '{}', '{}'),\n".format(
            i,
            random.choice(patients),
            random.choice(analysis_types),
            'Medical result',
            radar.random_date(start=datetime.date(year=2015, month=5, day=24),
                              stop=datetime.date(year=2019, month=5, day=24)),
        )

    return finalizeSql(sql)


def insert_employees(employees, type):
    # employees - range of employee ssns to insert
    # type - the employees type

    sql = "INSERT INTO Employee (ssn, name, surname, phone, specialization, salary, type) VALUES \n "

    names = samples["names"]
    surnames = samples["surnames"]
    specialization_types = samples["specializations"][type]

    for i in employees:
        sql += "({}, '{}', '{}', '+{}', '{}', {}, '{}'),\n".format(
            i, random.choice(names), random.choice(surnames),
            random.randint(10**11, 10**12 - 1),
            random.choice(specialization_types),
            random.randint(20, 60) * 1000, type)

    return finalizeSql(sql)


def insert_patients(patients, rooms):
    # patiens - range of patient ssn's to insert
    # rooms - range of available room ids

    sql = "INSERT INTO Patient (ssn, name, surname, gender, weight, birth_date, height, blood_type, phone, country, city, street, building, room_id) VALUES \n"

    names = samples["names"]
    surnames = samples["surnames"]
    genders = samples["genders"]
    blood_types = samples["blood_types"]
    countries = samples["countries"]
    cities = samples["cities"]
    streets = samples["streets"]

    for i in patients:
        sql += "({}, '{}', '{}', '{}', {}, '{}', {}, '{}', '+{}', '{}', '{}', '{}', {}, {}),\n".format(
            i, random.choice(names), random.choice(surnames),
            random.choice(genders), random.randint(45, 100),
            radar.random_date(start=datetime.date(year=1960, month=5, day=24),
                              stop=datetime.date(year=2013, month=5, day=24)),
            random.randint(80, 220), random.choice(blood_types),
            random.randint(10**11, 10**12 - 1), random.choice(countries),
            random.choice(cities), random.choice(streets),
            random.randint(1, 10), random.choice(rooms))

    return finalizeSql(sql)


def insert_rooms(rooms, beds):
    # rooms - range of room ids to insert
    # beds - range of possible bed ids per room

    sql = "INSERT INTO Room (id, type, quantity_of_beds) VALUES \n"
    room_types = samples["room_types"]

    for i in rooms:
        sql += "({}, '{}', {}),\n".format(i, random.choice(room_types),
                                          random.choice(beds))

    return finalizeSql(sql)


def insert_logs(logs):
    # logs - available logs ids

    sql = "INSERT INTO Log (id, name, description, time) VALUES \n"

    for i in logs:
        sql += "({}, '{}', '{}', '{}'),\n".format(
            i, "log_{}".format(i), "initialization",
            radar.random_date(start=datetime.datetime(year=2015,
                                                      month=5,
                                                      day=24),
                              stop=datetime.datetime(year=2019,
                                                     month=5,
                                                     day=24)))

    return finalizeSql(sql)


def insert_inventory(inventory_items):
    # inventory_items - available ids of inventory items

    sql = "INSERT INTO Inventory_item (id, name, quantity, type, supplier, cost) VALUES \n"

    items = samples["inventory_items"]
    suppliers = samples["suppliers"]

    for i in inventory_items:
        sql += "({}, '{}', {}, '{}', '{}', {}),\n".format(
            i, random.choice(items), random.randint(2, 10), 'medicine',
            random.choice(suppliers),
            random.randint(10, 50) * 500)

    return finalizeSql(sql)


def insert_treatment_plans(treatment_plans, employees, patients):
    # God help the one who will try to read this function, أَسْتَغْفِرُ اللّٰهَ‎

    # treatment_plans - available ids of treatment plans
    # employees - available employee ssns
    # patients - available patient ssns

    sql = ""

    n = len(treatment_plans)
    doc_snn = random.choices(employees, k=n)
    pat_snn = random.choices(patients, k=n)

    two_weeks = 1209600
    treats = samples["treatments"]

    diag_sql = ""
    for i, diag in enumerate(treats.keys()):
        diag_sql += "({}, '{}'),\n".format(i, diag)
    sql += "INSERT INTO Diagnoses VALUES \n{}\n".format(finalizeSql(diag_sql))

    c = 0
    proc_sql = ""
    thing = {}
    opthing = {}
    for i, diag in enumerate(treats.keys()):
        a = []
        for e2 in treats[diag]:
            if (not (e2 in opthing)):
                proc_sql += "({}, '{}'),\n".format(c, e2)
                a.append(c)
                opthing[e2] = c
                c += 1
            else:
                a.append(opthing[e2])
        thing[i] = a

    sql += "INSERT INTO Procedures VALUES \n{}\n".format(finalizeSql(proc_sql))

    tp_sql = ""
    td_sql = ""
    tpr_sql = ""
    for i in range(n):
        hos_date = radar.random_date(start=datetime.date(year=2015,
                                                         month=1,
                                                         day=1),
                                     stop=datetime.date(year=2019,
                                                        month=1,
                                                        day=1))
        timestamp = datetime.datetime.combine(hos_date,
                                              datetime.time(0, 0)).timestamp()
        dis_date = datetime.date.fromtimestamp(timestamp + two_weeks)
        tp_sql += "({}, {}, {}, '{}', '{}'),\n".format(treatment_plans[i],
                                                       doc_snn[i], pat_snn[i],
                                                       dis_date, hos_date)
        illness = random.sample(range(len(treats)), 1)
        for e in illness:
            td_sql += "({}, {}),\n".format(treatment_plans[i], e)
            tpr_sql += "({}, {}),\n".format(treatment_plans[i],
                                            random.choice(thing[e]))

    sql += "INSERT INTO Treatment_plan VALUES\n{}\n".format(
        finalizeSql(tp_sql))
    sql += "INSERT INTO Treatment_diagnoses  VALUES\n{}\n".format(
        finalizeSql(td_sql))
    sql += "INSERT INTO Treatment_procedures VALUES\n{}\n".format(
        finalizeSql(tpr_sql))

    return sql
