function [ fnEval ] = zasin( x, y, z )
%ZASIN 
%   Function used to clean up cubeGrav

top = z^2 + y^2 + y*radius(x,y,z);
bottom = (y + radius(x,y,z))*radius(0,y,z);
fnEval = z*asin(top/bottom);

end

