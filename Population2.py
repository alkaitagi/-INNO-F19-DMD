from  random import random, choice, randint, sample, shuffle
import radar
import datetime


def yapicae():
    s = ['q', 'w', 'r', 't', 'p', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'z', 'x', 'c', 'v', 'b', 'n', 'm']
    g = ['e', 'a', 'y', 'u', 'i', 'o', 'a']
    st = ""
    for i in range(5):
        st += choice(s)
        st += choice(g)
    return st


def logs(i):
    lgs = list(open('logs.txt'))
    print("INSERT INTO Log VALUES")
    for i in range(i - 1):
        shit, time, type, name = choice(lgs).split(sep=" ", maxsplit=3)
        print("({}, '{}', '{}', '{}'),".format(i, name, type, time))
    shit, time, type, name = choice(lgs).split(sep=" ", maxsplit=3)
    print("({}, '{}', '{}', '{}');".format(i + 1, name, type, time))


def inventory(i):
    types = ["medication", "food"]
    drugs = list(open('medic.txt'))

    print("INSERT INTO Log VALUES")
    ans = ""
    sup = [yapicae() for i in range(20)]
    for i in range(i - 1):
        ans += "( {}, '{}', '{}', '{}', '{}', '{}' ),\n".format(i, choice(drugs), randint(1, 100), types[0], yapicae(),
                                                                randint(1, 30) * 1000)
        ans += "( {}, '{}', '{}', '{}', '{}', '{}' ),\n".format(i, choice(sup), randint(1, 100), types[1], yapicae(),
                                                                randint(1, 30) * 1000)
    ans = list(ans)
    ans[-2] = ';'
    print(''.join(ans))


def Treatment_plan(n, doc_ssn1, doc_snn_2, pat_snn1, pat_snn_2):
    ids = list(range(1, n + 1))
    shuffle(ids)
    doc_snn = []
    for j in range(n):
        doc_snn.append(randint(doc_ssn1, doc_snn_2))

    pat_snn = []
    for j in range(n):
        pat_snn.append(randint(pat_snn1, pat_snn_2))

    two_weeks = 1209600
    treats = list(open("Treatments.txt"))
    for i in range(len(treats)):
        treats[i] = treats[i].replace("\n", "")

    while treats.count(""):
        treats.remove("")

    ans = ""
    for i, pro in enumerate(treats):
        ans += "({}, '{}'),".format(i, pro.split(";")[0])
    print("INSERT INTO Diagnoses VALUES " + ans[:-1] + ";\n")

    c = 0
    ans = ""
    thing = {}
    for i, pro in enumerate(treats):
        a = []
        for e2 in pro.split(";")[1:]:
            ans += "({}, '{}'),".format(c, e2)
            a.append(c)
            c += 1
        thing[i] = a

    print("INSERT INTO Procedures VALUES " + ans[:-1] + ";\n")

    ans1 = ""
    ans2 = ""
    ans3 = ""
    for i in range(n):
        hos_date = radar.random_date(start=datetime.date(year=2015,
                                                         month=1,
                                                         day=1),
                                     stop=datetime.date(year=2019,
                                                        month=1,
                                                        day=1))
        timestamp = datetime.datetime.combine(hos_date, datetime.time(0, 0)).timestamp()
        dis_date = datetime.date.fromtimestamp(timestamp + two_weeks)
        ans1 += "({}, {}, {}, '{}', '{}'),".format(ids[i], doc_snn[i], pat_snn[i], dis_date, hos_date)
        illness = sample(range(len(treats)), 3)
        for e in illness:
            ans2 += "({}, {}, {}, {}),".format(ids[i], doc_snn[i], pat_snn[i], e)
            ans3 += "({}, {}, {}, {}),".format(ids[i], doc_snn[i], pat_snn[i], choice(thing[e]))

    print("INSERT INTO Treatment_plan VALUES" + ans1[:-1] + ";")
    print("INSERT INTO Diagnoses VALUES" + ans2[:-1] + ";")
    print("INSERT INTO Procedures VALUES" + ans3[:-1] + ";")

Treatment_plan(5, 1, 100, 101, 200)
