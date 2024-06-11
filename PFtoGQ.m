O = input("Longitude of ascending node: "); 
w = input("Argument of periapse: ");
i = input("Inclination: ");

x = input("Enter x value: "); 
y = input("Enter y value: ");
z = input("Enter z value: ");

PF = [x; y; z];

A = [cosd(O)*cosd(w)-sind(O)*cosd(i)*sind(w) -cosd(O)*sind(w)-sind(O)*cosd(i)*cosd(w) sind(O)*sind(i); 
    sind(O)*sind(w)+cosd(O)*cosd(i)*sind(w) -sind(O)*sind(w)+cosd(O)*cosd(i)*cosd(w) -cosd(O)*sind(i); 
    sind(i)*sind(w) sind(i)*cosd(w) cosd(i)];

GQ = A*PF