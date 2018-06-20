function [ radius ] = radius( x,y,z )
%RADIUS returns the radius of the function
%   Original intention to clean up the Gmatrix function for gravitational
%   inversion.

radius = sqrt( x^2 + y^2 + z^2);

end

