import os
import psycopg2
import json
from populator import populate
from prettytable import from_db_cursor
from pydoc import locate


def displayQueries(queries):
    i = 0
    print('Available queries:')
    for query in queries:
        i += 1
        print('{}. {}'.format(i, query["title"]))


def loadQueries():
    with open('json/queries.json') as file:
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
# populate()

while True:
    info = queries[int(input('\nSelect: ')) - 1]

    with open('sql/queries/' + info["file"]) as query:
        cur.execute(query.read(), readArguments(info["args"]))
        print(from_db_cursor(cur))

    print('Executed')
