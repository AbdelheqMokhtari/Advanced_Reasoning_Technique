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

% Structure terms
reachable(X,Y,noroute):-connected(X,Y,_L).
reachable(X,Y,route(Z,R)):-connected(X,Z,_L),
                           connected(Z,Y,R).