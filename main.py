import os
import psycopg2
import json


def displayQueries(queries):
    i = 0
    print('Available queries:')
    for query in queries:
        i += 1
        print(f'{i}. {query["display"]}')


def loadQueries():
    with open('queries/index.json') as file:
        return json.load(file)


con = psycopg2.connect(os.environ['DATABASE_URL'], sslmode='require')
cur = con.cursor()

queries = loadQueries()
displayQueries(queries)

while True:
    i = int(input('\nSelect: ')) - 1

    with open(f'queries/{queries[i]["file"]}') as query:
        cur.execute(query.read())
        print(cur.fetchall())

    print('Executed')

con.commit()
con.close()
