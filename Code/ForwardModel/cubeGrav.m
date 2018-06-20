function [ Fz ] = cubeGrav(x0,x1,x2,y0,y1,y2,z0,z1,z2)
%CUBEGRAV using Blakely grav model this function finds where the boundarys
%of the cube are relative to the obs point and will solve an equivlent
%problem in the 1st quadrant.
%   Detailed explanation goes here

%I am just shifting them here, even though the blakely algorithm does it,
%but I would need to do this anyway to figure out my quadrants, just going
%to keep it to the same method.
x20 = x2 - x0;
x10 = x1 - x0;
y20 = y2 - y0;
y10 = y1 - y0;
z20 = z2 - z0;
z10 = z1 - z0;

%Get werid negitive values without this
almostZero = 0;


% Case 1 cube is in the 1st quadrant.
if (z20 >= 0 && z10 >= 0 && y20 >= 0 && y10 >= 0 && x20 >= 0 && x10 >= 0)
    %Fz = cubeGravFirstQuad( z2, z1, y2, y1, x2, x1);
     Fz  = blakelyGrav( 0,x10,x20,0,y10,y20,0,z10,z20 );
     

% Case 2 cube is in the 2nd quadrant.
elseif (z20 >= 0 && z10 >= 0 && y20 >= 0 && y10 >= 0 && x20 < 0 && x10 < 0)
    %Fz = cubeGravFirstQuad( z2, z1, y2, y1, abs(x1), abs(x2));
    Fz  = blakelyGrav( 0,abs(x20),abs(x10),0,y10,y20,0,z10,z20 );

%Case 3 cube is in the 3rd quadrant.
elseif (z20 >= 0 && z10 >= 0 && y20 < 0 && y10 < 0 && x20 < 0 && x10 < 0)
    %Fz = cubeGravFirstQuad( z2, z1, abs(y1), abs(y2), abs(x1), abs(x2));
    Fz = blakelyGrav( 0,abs(x20),abs(x10),0,abs(y20),abs(y10),0,z10,z20 );


%Case 4 cube is in 4th quadrant.
elseif (z20 >= 0 && z10 >= 0 && y20 < 0 && y10 < 0 && x20 >= 0 && x10 >= 0)
    %Fz = cubeGravFirstQuad( z2, z1, abs(y1), abs(y2), x2, x1);
    Fz  = blakelyGrav( 0,x10,x20,0,abs(y20),abs(y10),0,z10,z20 );


%Case 5 cube between the 1st and 4th quadrant.
elseif (z20 >= 0 && z10 >= 0 && y20 >= 0 && y10 < 0 && x20 >= 0 && x10 >= 0)
    %Fz = cubeGravFirstQuad( z2, z1, y2, almostZero, x2, x1) +  cubeGravFirstQuad( z2, z1, abs(y1), almostZero, x2, x1);
    Fz  = blakelyGrav( 0,x10,x20,0,almostZero,y20,0,z10,z20 ) + blakelyGrav( 0,x10,x20,0,almostZero,abs(y10),0,z10,z20 );

%Case 6 cube is between the 1st and 2nd quadrant
elseif (z20 >= 0 && z10 >= 0 && y20 >= 0 && y10 >= 0 && x20 >= 0 && x10 < 0)
    %Fz = cubeGravFirstQuad( z2, z1, y2, y1, x2, almostZero) +  cubeGravFirstQuad( z2, z1, y2, y1, abs(x1), almostZero);
    Fz = blakelyGrav( 0,almostZero,x20,0,y10,y20,0,z10,z20 ) + blakelyGrav( 0,almostZero,abs(x10),0,y10,y20,0,z10,z20 ); 

%Case 7 cube is between 2nd and 3rd quadrant
elseif (z20 >= 0 && z10 >= 0 && y20 >= 0 && y10 < 0 && x20 < 0 && x10 < 0)
    %Fz = cubeGravFirstQuad( z2, z1, y2, almostZero, abs(x1), abs(x2)) +  cubeGravFirstQuad( z2, z1, abs(y1), almostZero, abs(x1), abs(x2));
     Fz = blakelyGrav( 0,abs(x20),abs(x10),0,almostZero,y20,0,z10,z20 ) + blakelyGrav( 0,abs(x20),abs(x10),0,almostZero,abs(y10),0,z10,z20 );


%Case 8 cube is between 3rd and 4th quadrant
elseif (z20 >= 0 && z10 >= 0 && y20 < 0 && y10 < 0 && x20 >= 0 && x10 < 0)
    %Fz = cubeGravFirstQuad( z2, z1, abs(y1), abs(y2), x2, almostZero) +  cubeGravFirstQuad( z2, z1, abs(y1), abs(y2), abs(x1), almostZero);
    Fz = blakelyGrav( 0,almostZero,x20,0,abs(y20),abs(y10),0,z10,z20 ) + blakelyGrav( 0,almostZero,abs(x10),0,abs(y20),abs(y10),0,z10,z20 ); 

%Case 9 cube is in all four quadrants
elseif (z20 >= 0 && z10 >= 0 && y20 >= 0 && y10 < 0 && x20 >= 0 && x10 < 0)
    %Fz = cubeGravFirstQuad( z2, z1, y2,0, x2, almostZero) +  cubeGravFirstQuad( z2, z1, y2, almostZero, abs(x1), almostZero)...
    %+ cubeGravFirstQuad( z2, z1, abs(y1), almostZero, abs(x1), almostZero) + cubeGravFirstQuad( z2, z1, abs(y1), almostZero, x2, almostZero);
    Fz = blakelyGrav( 0,almostZero,x20,0,almostZero,y20,0,z10,z20 ) + blakelyGrav( 0,almostZero,abs(x10),0,almostZero,y20,0,z10,z20 ) + blakelyGrav( 0,almostZero,x20,0,almostZero,abs(y10),0,z10,z20 )+...
        + blakelyGrav( 0,almostZero,abs(x10),0,almostZero,abs(y10),0,z10,z20 );
end


end

