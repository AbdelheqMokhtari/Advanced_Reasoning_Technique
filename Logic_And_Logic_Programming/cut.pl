likes(peter, maria).
likes(peter, john).

firend(X, Y) :- likes(X, Y), !, writes(X, Y).
firend(X, Y) :- likes(X, Y).