function [A,B,C,D] = getPlane(Normal_Vector, point)

A = Normal_Vector(1,1);
B = Normal_Vector(2,1);
C = Normal_Vector(3,1);
D = -point*Normal_Vector;

end