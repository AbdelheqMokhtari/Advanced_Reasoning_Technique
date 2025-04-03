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

% Nearby stations
nearby(X,Y):-connected(X,Y,_L).
nearby(X,Y):-connected(X,Z,L),connected(Z,Y,L).

% Directly connected stations  
not_too_far(X,Y):- connected(X, Y, _L).
not_too_far(X,Y):- connected(Y, X, _L).

% Connected stations with one station in between same line 
not_too_far(X,Y):- connected(X, Z, L), connected(Z,Y,L).
not_too_far(X,Y):- connected(Y, Z, L), connected(Z,X,L).

% Connected stations with one station in between different line
not_too_far(X,Y):- connected(X, Z, _L1), connected(Z,Y,_L2), X \= Y.
not_too_far(X,Y):- connected(Y, Z, _L1), connected(Z,X,_L2), X \= Y.