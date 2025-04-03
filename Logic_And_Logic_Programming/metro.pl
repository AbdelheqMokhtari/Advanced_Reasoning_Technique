% Connections with line names
connected(bond_street, oxford_circus, central).
connected(oxford_circus, tottenham_court_road, central).
connected(bond_street, green_park, jubilee).
connected(green_park, charing_cross, jubilee).
connected(green_park, piccadilly_circus, piccadilly).
connected(piccadilly_circus, leicester_square, piccadilly).
connected(green_park, oxford_circus, victoria).
connected(oxford_circus, piccadilly_circus, bakerloo).
connected(piccadilly_circus, charing_cross, bakerloo).
connected(tottenham_court_road, leicester_square, northern).
connected(leicester_square, charing_cross, northern).

% reverses connection
connected(Y,X,L):- connected(X,Y,L).


% Nearby stations
nearby(X,Y):- connected(X,Y,_L).
nearby(X,Y):- connected(X,Z,L),connected(Z,Y,L).



% Directly connected stations  
not_too_far(X,Y):- connected(X, Y, _L).

% Connected stations with one station in between same line 
not_too_far(X,Y):- connected(X, Z, L), connected(Z,Y,L).

% Connected stations with one station in between different line
not_too_far(X,Y):- connected(X, Z, _L1), connected(Z,Y,_L2), X \= Y.

% non-recursive definition 
reachable(X,Y):-connected(X,Y,L).
reachable(X,Y):-connected(X,Z,L1),connected(Z,Y,L2).
reachable(X,Y):-connected(X,Z1,L1),connected(Z1,Z2,L2),
                connected(Z2,Y,L3).

% recursive definition
reachable(X,Y):-connected(X,Y,_L).
reachable(X,Y):-connected(X,Z,L),
                reachable(Z,Y). % recursive call to find a connection from Z To Y 