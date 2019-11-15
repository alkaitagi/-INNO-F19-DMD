from  random import random, choice, randint, sample
from  KEK import *
import radar

def yapicae():
    s = ['q', 'w', 'r', 't', 'p', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'z', 'x', 'c', 'v', 'b', 'n', 'm']
    g = ['e', 'a', 'y', 'u', 'i', 'o', 'a']
    st = ""
    for i in range(5):
        st += choice(s)
        st += choice(g)
    return st


def logs(i):
    lgs = list(open('logs'))
    print("INSERT INTO Log VALUES")
    for i in range(i - 1):
        shit, time, type, name = choice(lgs).split(sep=" ", maxsplit=3)
        print("({}, '{}', '{}', '{}'),".format(i, name, type, time))
    shit, time, type, name = choice(lgs).split(sep=" ", maxsplit=3)
    print("({}, '{}', '{}', '{}');".format(i + 1, name, type, time))


def inventory(i):
    types = ["medication", "food"]
    drugs=list(open('medic'))

    print("INSERT INTO Log VALUES")
    ans=""
    sup=[yapicae() for i in range(20)]
    for i in range(i-1):
        ans+="( {}, '{}', '{}', '{}', '{}', '{}' ),\n".format(i, choice(drugs), randint(1, 100), types[0], yapicae(),
                                                            randint(1, 30) * 1000)
        ans+="( {}, '{}', '{}', '{}', '{}', '{}' ),\n".format(i, choice(sup), randint(1, 100), types[1], yapicae(),
                                                             randint(1, 30) * 1000)
    ans=list(ans)
    ans[-2]=';'
    print(''.join(ans))


def Treatment_plan(i,doc_ssn1,doc_snn_2,pat_snn1,pat_snn_2):
    ids=sample(range(i))
    doc_snn=sample(doc_ssn1,doc_snn_2)
    pat_snn=sample(pat_snn1,pat_snn_2)


inventory(5)
