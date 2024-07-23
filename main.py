import json

def json_la_text(nume_fisier_json, nume_fisier_prolog):
    with open(nume_fisier_json, 'r') as f:
        date = json.load(f)

    date_sortate = dict(sorted(date.items()))

    with open(nume_fisier_prolog, 'w') as f:
        for cheie, valoare in date_sortate.items():
            initial = cheie[0]
            f.write('word' + str(initial).upper() + '("' + str(cheie) + '").\n')

json_la_text('words_dictionary.json', 'words.pl')