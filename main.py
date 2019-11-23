import os
import psycopg2
import json


def displayQueries(queries):
    i = 0
    print('Available queries:')
    for query in queries:
        i += 1
        print('{}. {}'.format(i, query["display"]))


def loadQueries():
    with open('queries/index.json') as file:
        return json.load(file)


con = psycopg2.connect(os.environ['DATABASE_URL'], sslmode='require')
cur = con.cursor()

queries = loadQueries()
displayQueries(queries)

while True:
    i = int(input('\nSelect: ')) - 1
    info = queries[i]
    with open('queries/' + info["file"]) as query:
        sql = query.read()
        argc = info["argc"]

        if argc > 0:
            args = input("Input {} argument(s): ".format(argc)).split(' ', argc)
            for a in range(argc):
                sql = sql.replace("{ " + "ARG{}".format(a) + " }", args[a])

        cur.execute(sql.read())
        print(cur.fetchall())

    print('Executed')

con.commit()
con.close()
