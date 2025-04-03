% Base case: An empty list is a valid list.
list([]).

% Recursive case: A list is valid if it has a head and a tail that is also a list.
list([_|Tail]) :- list(Tail).

% Base case: The empty list is of even length.
even_length([]).

% Recursive case: Two elements removed means the list remains even.
even_length([_,_|Tail]) :- even_length(Tail).

% Base case: A single element list is of odd length.
odd_length([_]).

% Recursive case: Removing two elements keeps the length odd.
odd_length([_,_|Tail]) :- odd_length(Tail).