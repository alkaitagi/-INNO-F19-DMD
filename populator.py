import os
import psycopg2
import inserts
import json

conn = psycopg2.connect(os.environ['DATABASE_URL'], sslmode='require')

cur = conn.cursor()
cur.execute("DROP SCHEMA public CASCADE; CREATE SCHEMA public;")

with open('tables.sql') as tables:
    cur.execute(tables.read())


def readValue(val):
    if len(val) == 1:
        return val[0]
    else:
        return list(range(val[0], val[1]))


with open('population.json') as file:
    data = json.load(file)

    json_rooms = list(range(0, 5))
    json_beds = list(range(5, 10))
    json_patients = list(range(101, 105))
    json_doctors = list(range(1, 5))
    json_nurses = list(range(5, 10))
    json_analyzes = list(range(0, 5))
    json_inventory_items = list(range(0, 3))
    json_treatment_plans = list(range(0, 3))
    json_logs = list(range(0, 3))
    json_prescribes = 3
    json_attends = 100
    json_chats = 3

rooms = inserts.insert_rooms(json_rooms, json_beds)
patients = inserts.insert_patients(json_patients, json_rooms)
doctors = inserts.insert_employees(json_doctors, "doctor")
nurses = inserts.insert_employees(json_nurses, "nurse")
prescribes = inserts.insert_prescribes(json_prescribes, json_doctors,
                                       json_patients)
analysis_reports = inserts.insert_analysis_results(json_analyzes,
                                                   json_patients)
attends = inserts.insert_attends(json_attends, json_doctors, json_patients)
chats = inserts.insert_chats(json_chats, json_doctors, json_patients)
inventory = inserts.insert_inventory(json_inventory_items)
treatment_plans = inserts.insert_treatment_plans(json_treatment_plans,
                                                 json_doctors, json_patients)
uses = inserts.insert_uses(json_treatment_plans, json_inventory_items)
logs = inserts.insert_logs(json_logs)

cur.execute(rooms)
cur.execute(patients)
cur.execute(doctors)
cur.execute(nurses)
cur.execute(prescribes)
cur.execute(analysis_reports)
cur.execute(attends)
cur.execute(chats)
cur.execute(inventory)
cur.execute(treatment_plans)
cur.execute(uses)
cur.execute(logs)

print(rooms,
      patients,
      doctors,
      nurses,
      prescribes,
      analysis_reports,
      attends,
      chats,
      inventory,
      treatment_plans,
      uses,
      logs,
      sep="\n")

conn.commit()
conn.close()
