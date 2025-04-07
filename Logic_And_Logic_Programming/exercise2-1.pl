% negation \+ operator
% Logical OR with semicolon ;
% Logical AND with comma , 

% my solution

% 1. Persons are happy or sad
person(X):- happy(X);sad(X).

2. No person is both happy and sad
\+ person(X):- happy(X),sad(X).

3. Sad persons are not happy
sad(X),person(X) :- \+ happy(X).

% 4. Non-happy persons are sad
\+ happy(X),person(X) :- sad(X).

% other solution

% 1. Persons are happy or sad
happy(X); sad(X) :- person(X).

% 2. No person is both happy and sad (Integrity Constraint)
:- happy(X), sad(X).

% 3. Sad persons are not happy
\+ happy(X) :- sad(X).

% 4. Non-happy persons are sad
sad(X) :- \+ happy(X).