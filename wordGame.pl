:-include('words.pl').

randomize(Y, Z) :-
    random(X), 
    number_string(X, Atom),
    string_concat("0.", Atom, FloatAtom),
    number_string(Float, FloatAtom),
    Y is floor(Float * (Z + 1)) - 1.

nth(_, [], 0).
nth(E, [E|_], 0).
nth(E, [_|T], Index) :-
    nth(E, T, Index1),
    Index is Index1 + 1.

apelare(Initial, Element, Used) :-
    atom_string(Initial, SInitial),
    string_upper(SInitial, UpperCase),
    string_concat("word", UpperCase, String),
    atom_string(Predicat, String),
    findall(E, (call(Predicat, E), isUsed(Used, E)), ListaElemente),
    length(ListaElemente, Lungime),
    randomize(Y, Lungime),
    R is integer(Y),
    nth(Element, ListaElemente, R).

last(Word, Chr):-
    name(Word, Atom),
    reverse(Atom, [Chr | _]).

first(Word, Chr):-
    name(Word, [Chr | _]).

verify(Word, Answer):-
    last(Word, Chr),
    first(Answer, Chr).

isUsed(Used, Answer):-
    \+member(Answer, Used).

exist(Word):-
    first(Word, Chr),
    name(Initial, [Chr]),
    atom_string(Initial, SInitial),
    string_upper(SInitial, UpperCase),
    string_concat("word", UpperCase, String),
    atom_string(Predicat, String),
    atom_string(Word, SWord),
    call(Predicat, SWord).

used(Used, I, UsedX):-
    findall(El, (
        member(El, Used),
        first(El, I)
        ), UsedX).

score(List, Score):-
    length(List, Length),
    Score is (Length - 1) / 2.

play(Used, ''):- 
    write("Joc terminat"), nl,
    score(Used, Score),
    write("Scor: "), write(Score), nl.

play(Used, I):-
    apelare(I, Answer, Used),
    append(Used, [Answer], Used1),
    write(Answer), nl,
    last(Answer, Chr),
    used(Used1, Chr, Usedx),
    write(Usedx), nl,
    read(Word),
    (
    ((verify(Answer, Word), isUsed(Used1, Word), exist(Word)))->
        (append(Used1, [Word], Used2),
        write(Word), nl,
        last(Word, C),
        name(I1, [C]),
        play(Used2,I1));
        (write("Raspunsul dvs. nu este valid "), play(Used1, ''))
    ).




