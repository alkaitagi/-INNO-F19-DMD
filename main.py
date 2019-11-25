import os
import psycopg2
import json
from prettytable import from_db_cursor
from pydoc import locate


def displayQueries(queries):
    i = 0
    print('Available queries:')
    for query in queries:
        i += 1
        print('{}. {}'.format(i, query["title"]))


def loadQueries():
    with open('queries/index.json') as file:
        return json.load(file)


def readArguments(args):
    dict = {}

    for i, a in enumerate(args):
        dict["arg{}".format(i)] = locate(a["type"])(input("Write {}: ".format(
            a["name"])))

    return dict


con = psycopg2.connect(os.environ['DATABASE_URL'], sslmode='require')
cur = con.cursor()

queries = loadQueries()
displayQueries(queries)

while True:
    info = queries[int(input('\nSelect: ')) - 1]

    with open('queries/' + info["file"]) as query:
        cur.execute(query.read(), readArguments(info["args"]))
        print(from_db_cursor(cur))

    print('Executed')

con.commit()
con.close()
