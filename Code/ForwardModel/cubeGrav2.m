function [ Fz ] = cubeGrav2( z2, z1, y2, y1, x2, x1 )
%CUBEGRAV Will calculate the gravity in the Z direction for a cube in space
%where the cube is in Z positive, but can be cross the Y or X boundarys. 
%   Using the method described in NAGY 1966 the solutin solves for a cube
%   in the 1st quadrant.  Since all we are calculating is the the force in
%   the z direction we can always solve an equvilent problem for the 1st
%   quadrant because gravity is only radially dependent.
%
%   This program will check to see what quadrant the cube is in, 
%   or if it is crossing an axis.   And if it is a differant quadrant it
%   will solve an equvilent problem in the 1st quadrant.  If it is at an
%   asix crossing it will also solve an equvilent problem in the 1
%   quadrant, but summing the smaller squares to get the data.
%   The value returned is Fz/(G*rho)

%Function will return complex values if this is to close to zero.  This
%number depends on your geometry.
almostZero = 1e-5;

%When the function is given zero it returns a complex number, so 

% Case 1 cube is in the 1st quadrant.
if (z2 >= 0 && z1 >= 0 && y2 >= 0 && y1 >= 0 && x2 >= 0 && x1 >= 0)
    Fz = cubeGravFirstQuad( z2, z1, y2, y1, x2, x1);


% Case 2 cube is in the 2nd quadrant.
elseif (z2 >= 0 && z1 >= 0 && y2 >= 0 && y1 >= 0 && x2 < 0 && x1 < 0)
    Fz = cubeGravFirstQuad( z2, z1, y2, y1, abs(x1), abs(x2));

%Case 3 cube is in the 3rd quadrant.
elseif (z2 >= 0 && z1 >= 0 && y2 < 0 && y1 < 0 && x2 < 0 && x1 < 0)
    Fz = cubeGravFirstQuad( z2, z1, abs(y1), abs(y2), abs(x1), abs(x2));


%Case 4 cube is in 4th quadrant.
elseif (z2 >= 0 && z1 >= 0 && y2 < 0 && y1 < 0 && x2 >= 0 && x1 >= 0)
    Fz = cubeGravFirstQuad( z2, z1, abs(y1), abs(y2), x2, x1);


%Case 5 cube between the 1st and 4th quadrant.
elseif (z2 >= 0 && z1 >= 0 && y2 >= 0 && y1 < 0 && x2 >= 0 && x1 >= 0)
    Fz = cubeGravFirstQuad( z2, z1, y2, almostZero, x2, x1) +  cubeGravFirstQuad( z2, z1, abs(y1), almostZero, x2, x1);


%Case 6 cube is between the 1st and 2nd quadrant
elseif (z2 >= 0 && z1 >= 0 && y2 >= 0 && y1 >= 0 && x2 >= 0 && x1 < 0)
    Fz = cubeGravFirstQuad( z2, z1, y2, y1, x2, almostZero) +  cubeGravFirstQuad( z2, z1, y2, y1, abs(x1), almostZero);


%Case 7 cube is between 2nd and 3rd quadrant
elseif (z2 >= 0 && z1 >= 0 && y2 >= 0 && y1 < 0 && x2 < 0 && x1 < 0)
    Fz = cubeGravFirstQuad( z2, z1, y2, almostZero, abs(x1), abs(x2)) +  cubeGravFirstQuad( z2, z1, abs(y1), almostZero, abs(x1), abs(x2));


%Case 8 cube is between 3rd and 4th quadrant
elseif (z2 >= 0 && z1 >= 0 && y2 < 0 && y1 < 0 && x2 >= 0 && x1 < 0)
    Fz = cubeGravFirstQuad( z2, z1, abs(y1), abs(y2), x2, almostZero) +  cubeGravFirstQuad( z2, z1, abs(y1), abs(y2), abs(x1), almostZero);


%Case 9 cube is in all four quadrants
elseif (z2 >= 0 && z1 >= 0 && y2 >= 0 && y1 < 0 && x2 >= 0 && x1 < 0)
    Fz = cubeGravFirstQuad( z2, z1, y2,0, x2, almostZero) +  cubeGravFirstQuad( z2, z1, y2, almostZero, abs(x1), almostZero)...
    + cubeGravFirstQuad( z2, z1, abs(y1), almostZero, abs(x1), almostZero) + cubeGravFirstQuad( z2, z1, abs(y1), almostZero, x2, almostZero);
end

end

