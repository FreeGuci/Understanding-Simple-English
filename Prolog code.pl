:- dynamic fact/2.
:- dynamic rule/2.

sentence(is(A, B)) --> [A, is, a, B], {atom(A), atom(B)}.
sentence(a(A, B)) --> [a, A, is, a, B], {atom(A), atom(B)}.
sentence(question(A, B)) --> [is, A, a, B, ?], {atom(A), atom(B)}.

parse(Sentence, Clause) :-
    phrase(sentence(Clause), Sentence).

respond_to(is(A, B)) :-
    assertz(fact(A, B)),
    write('ok'), nl.

respond_to(a(A, B)) :-
    assertz(rule(A, B)),
    write('ok'), nl.

respond_to(question(A, B)) :-
    (   fact(A, B) -> write('yes'); 
        rule(X, B), fact(A, X) -> write('yes'); 
        write('unknown')
    ), nl.

talk :-
    repeat,
    write('Enter a sentence: '),
    read(Sentence),
    parse(Sentence, Clause),
    respond_to(Clause),
    Clause = stop.