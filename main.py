import os
import psycopg2
import json
from prettytable import from_db_cursor


def displayQueries(queries):
    i = 0
    print('Available queries:')
    for query in queries:
        i += 1
        print('{}. {}'.format(i, query["title"]))


def loadQueries():
    with open('queries/index.json') as file:
        return json.load(file)


def readArguments(sql, argc):
    if argc > 0:
        args = input("Write {} argument(s): ".format(argc)).split(' ', argc)
        for a in range(argc):
            sql = sql.replace("###ARG{}".format(a), args[a])
    return sql


con = psycopg2.connect(os.environ['DATABASE_URL'], sslmode='require')
cur = con.cursor()

queries = loadQueries()
displayQueries(queries)

while True:
    i = int(input('\nSelect: ')) - 1
    info = queries[i]
    with open('queries/' + info["file"]) as query:
        cur.execute(readArguments(query.read(), info["argc"]))
        print(from_db_cursor(cur))

    print('\nExecuted')

con.commit()
con.close()
