import random
import datetime
import radar
import string
import json

with open('samples.json') as file:
    samples = json.load(file)


def randomString(stringLength=10):
    # Generate a random string of fixed length

    letters = string.ascii_lowercase
    return ''.join(random.choice(letters) for i in range(stringLength))


def insert_uses(inv_id1, inv_id2, trm_id1, trm_id2):
    # a:b - available inventory id's
    # c:d - available trearment id's

    inserts = "INSERT INTO Uses (inventory_id, treatment_id) VALUES\n "

    l = min(min(inv_id2 - inv_id1, trm_id2 - trm_id1), 4)
    for k in range(l):
        inserts += "({}, {}),\n".format(inv_id1 + k, trm_id1 + k)

    inserts = inserts[:-2] + ';\n'
    return inserts


def insert_chat(l, emp_ssn1, emp_ssn2, pat_ssn1, pat_ssn2):
    # l - number of prescribes, i:j - available employee ssn, m:m - available patient ssn

    inserts = "INSERT INTO Chat (message_id, time, employee_ssn, patient_ssn, text) VALUES\n "

    for k in range(l):
        inserts += "('{}', '{}', {}, {}, '{}'),\n".format(
            randomString(50),
            radar.random_datetime(start=datetime.datetime(year=2015,
                                                          month=5,
                                                          day=24),
                                  stop=datetime.datetime(year=2019,
                                                         month=5,
                                                         day=24)),
            random.randint(emp_ssn1, emp_ssn2 - 1),
            random.randint(pat_ssn1, pat_ssn2 - 1), "Random message")
    inserts = inserts[:-2] + ';\n'
    return inserts


def insert_attends(l, emp_ssn1, emp_ssn2, pat_ssn1, pat_ssn2):
    # l - number of attends, i:j - available employee ssn, m:m - available patient ssn

    inserts = "INSERT INTO Attends (employee_ssn, patient_ssn, cost, description, date) VALUES\n "

    for k in range(l):
        inserts += "({}, {}, {}, '{}', '{}'),\n".format(
            random.randint(emp_ssn1, emp_ssn2 - 1),
            random.randint(pat_ssn1, pat_ssn2 - 1),
            random.randint(1000, 50000), "Attend description",
            radar.random_date(start=datetime.datetime(year=2015,
                                                      month=5,
                                                      day=24),
                              stop=datetime.datetime(year=2016,
                                                     month=5,
                                                     day=24)))
    inserts = inserts[:-2] + ';\n'
    return inserts


def insert_prescribe(l, emp_ssn1, emp_ssn2, pat_ssn1, pat_ssn2):
    # l - number of prescribes, i:j - available employee ssn, m:m - available patient ssn

    inserts = "INSERT INTO Prescribe (employee_ssn, patient_ssn, description, date) VALUES\n "

    for k in range(l):
        inserts += "({}, {}, '{}', '{}'),\n".format(
            random.randint(emp_ssn1, emp_ssn2 - 1),
            random.randint(pat_ssn1, pat_ssn2 - 1), "Doctor attends patient",
            radar.random_date(start=datetime.date(year=2015, month=5, day=24),
                              stop=datetime.date(year=2019, month=5, day=24)))
    inserts = inserts[:-2] + ';\n'
    return inserts


def insert_analysis_result(i, pat_ssn1, pat_ssn2):
    inserts = "INSERT INTO Analysis_result (id, patient_ssn, type, result, date) VALUES\n "

    for j in range(i):
        inserts += "({}, {}, '{}', '{}', '{}'),\n".format(
            j,
            random.randint(pat_ssn1, pat_ssn2 - 1),
            random.choice(samples["analysis_types"]),
            'Medical result',
            radar.random_date(start=datetime.date(year=2015, month=5, day=24),
                              stop=datetime.date(year=2019, month=5, day=24)),
        )
    inserts = inserts[:-2] + ';\n'
    return inserts


def insert_employee(pat_ssn1, pat_ssn2, type):
    inserts = "INSERT INTO Employee (ssn, name, surname, phone, specialization, salary, type) VALUES \n "
    for k in range(pat_ssn1, pat_ssn2):
        inserts += "({}, '{}', '{}', '+{}', '{}', {}, '{}'),\n".format(
            k, random.choice(samples["names"]), random.choice(samples["surnames"]),
            random.randint(10**11, 10**12 - 1),
            random.choice(samples["specializations"][type]),
            random.randint(20, 60) * 1000, type)

    inserts = inserts[:-2] + ';\n'
    return inserts


def insert_patient(pat_ssn1, pat_ssn2, room_id1, room_id2):
    # i:j - available ssn's m:n - available room_id's

    inserts = "INSERT INTO Patient (ssn, name, surname, gender, weight, birth_date, height, blood_type, phone, country, city, street, building, room_id) VALUES \n"
    for k in range(pat_ssn1, pat_ssn2):
        inserts += "({}, '{}', '{}', '{}', {}, '{}', {}, '{}', '+{}', '{}', '{}', '{}', {}, {}),\n".format(
            k, random.choice(samples["names"]), random.choice(samples["surnames"]),
            random.choice(samples["genders"]), random.randint(45, 100),
            radar.random_date(start=datetime.date(year=1960, month=5, day=24),
                              stop=datetime.date(year=2013, month=5, day=24)),
            random.randint(80, 220), random.choice(samples["blood_types"]),
            random.randint(10**11, 10**12 - 1),
            random.choice(samples["countries"]), random.choice(samples["cities"]),
            random.choice(samples["streets"]), random.randint(1, 10),
            random.randint(room_id1, room_id2 - 1))

    inserts = inserts[:-2] + ';\n'
    return inserts


def insert_room(room_id1, room_id2):
    inserts = "INSERT INTO Room (id, type, quantity_of_beds) VALUES \n"
    for k in range(room_id1, room_id2):
        inserts += "({}, '{}', {}),\n".format(k,
                                              random.choice(samples["room_types"]),
                                              random.randint(2, 10))

    inserts = inserts[:-2] + ';\n'
    return inserts


def insert_log(i):
    # i - number of logs id's

    inserts = "INSERT INTO Log (id, name, description, time) VALUES \n"

    for k in range(i):
        inserts += "({}, '{}', '{}', '{}'),\n".format(
            k, "log_{}".format(k), "initialization",
            radar.random_date(start=datetime.datetime(year=2015,
                                                      month=5,
                                                      day=24),
                              stop=datetime.datetime(year=2019,
                                                     month=5,
                                                     day=24)))

    inserts = inserts[:-2] + ';\n'
    return inserts


def insert_inventory(i):
    # i - number of inventory items id's

    inserts = "INSERT INTO Inventory_item (id, name, quantity, type, supplier, cost) VALUES \n"
    for k in range(i):
        inserts += "({}, '{}', {}, '{}', '{}', {}),\n".format(
            k, random.choice(samples["inventory_items"]), random.randint(2, 10),
            'medicine', random.choice(samples["suppliers"]),
            random.randint(10, 50) * 500)

    inserts = inserts[:-2] + ';\n'
    return inserts


def insert_treatment_plan_1(n, doc_ssn1, doc_snn_2, pat_snn1, pat_snn_2):

    inserts = "INSERT INTO Treatment_plan (id, doctor_ssn, patient_ssn, discharge_date, hospitalization_date, diagnoses, procedures) VALUES \n"
    for k in range(n):
        diagnoses = random.choice(list(samples.treatments.keys()))
        inserts += "({}, {}, {}, '{}', '{}', '{}', '{}'),\n".format(
            k, random.randint(doc_ssn1, doc_snn_2 - 1),
            random.randint(pat_snn1, pat_snn_2 - 1),
            radar.random_date(start=datetime.date(year=2014, month=5, day=24),
                              stop=datetime.date(year=2015, month=5, day=24)),
            radar.random_date(start=datetime.date(year=2012, month=5, day=24),
                              stop=datetime.date(year=2013, month=5, day=24)),
            diagnoses, random.choice(samples.treatments[diagnoses]))

    inserts = inserts[:-2] + ';\n'
    return inserts


def insert_treatment_plan(n, doc_ssn1, doc_snn_2, pat_snn1, pat_snn_2):
    ans = ""
    ids = list(range(0, n))
    random.shuffle(ids)
    doc_snn = []
    for j in range(n):
        doc_snn.append(random.randint(doc_ssn1, doc_snn_2 - 1))

    pat_snn = []
    for j in range(n):
        pat_snn.append(random.randint(pat_snn1, pat_snn_2 - 1))

    two_weeks = 1209600
    treats = list(open("Treatments.txt"))
    for i in range(len(treats)):
        treats[i] = treats[i].replace("\n", "")

    while treats.count(""):
        treats.remove("")

    string = ""
    for i, pro in enumerate(treats):
        string += "({}, '{}'),\n".format(i, pro.split(";")[0])
    ans += "INSERT INTO Diagnoses VALUES \n" + string[:-2] + ";\n\n"

    c = 0
    string = ""
    thing = {}
    opthing = {}
    for i, pro in enumerate(treats):
        a = []
        for e2 in pro.split(";")[1:]:
            if (not (e2 in opthing)):
                string += "({}, '{}'),\n".format(c, e2)
                a.append(c)
                opthing[e2] = c
                c += 1
            else:
                a.append(opthing[e2])
        thing[i] = a

    ans += "INSERT INTO Procedures VALUES \n" + string[:-2] + ";\n\n"

    string1 = ""
    string2 = ""
    string3 = ""
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
        string1 += "({}, {}, {}, '{}', '{}'),\n".format(
            ids[i], doc_snn[i], pat_snn[i], dis_date, hos_date)
        illness = random.sample(range(len(treats)), 3)
        for e in illness:
            string2 += "({}, {}),\n".format(ids[i], e)
            string3 += "({}, {}),\n".format(ids[i], random.choice(thing[e]))

    ans += "INSERT INTO Treatment_plan VALUES\n" + string1[:-2] + ";\n\n"
    ans += "INSERT INTO Treatment_diagnoses  VALUES\n" + string2[:-2] + ";\n\n"
    ans += "INSERT INTO Treatment_procedures VALUES\n" + string3[:-2] + ";\n\n"
    return ans


#print(insert_treatment_plan(5, 1, 100, 101, 200))