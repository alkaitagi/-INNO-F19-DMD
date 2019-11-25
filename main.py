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
    argc = len(args)

    if argc > 0:
        words = input("Write {} argument(s): ".format(argc)).split(' ', argc)
        for i in range(argc):
            dict["arg{}".format(i)] = locate(args[i])(words[i])
    return dict


con = psycopg2.connect(os.environ['DATABASE_URL'], sslmode='require')
cur = con.cursor()

queries = loadQueries()
displayQueries(queries)

while True:
    i = int(input('\nSelect: ')) - 1
    info = queries[i]
    with open('queries/' + info["file"]) as query:
        cur.execute(query.read(), readArguments(info["args"]))
        print(from_db_cursor(cur))

    print('\nExecuted')

con.commit()
con.close()
