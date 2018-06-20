function [ Fz, Line ] = cubeGravFirstQuad( z2, z1, y2, y1, x2, x1)
%CUBEGRAV takes in the coordinates of the cube, where x1,y1,z1 are the
%lower bounds and x2,y2,y3 are the upper bounds.  
%The function assumes:
%The observation point is at x = (0,0,0).
%And the cube is in the first quadrant.  Since this only calculates the
%force downwards there will be another function that can differentate
%between when the cube crosses the x axis.
%This forward model is an analytical model for a cube, and is quite
%complicated.  The derivation can be found in Nagy(1966.)
%There is an error in expression 8 on the paper, so the analyitical
%expression was derivied manually.

% Case when the cube is in the 1st quadrant.

 Line(1) = (intStep(x2, y2, z2) - intStep(x2, y2, z1));
 Line(2) = (intStep(x2, y1, z2) - intStep(x2, y1, z1));
 Line(3) = (intStep(x1, y2, z2) - intStep(x1, y2, z1));
 Line(4) = (intStep(x1, y1, z2) - intStep(x1, y1, z1));
 
 Fz = -((Line(1) - Line(2)) - (Line(3) - Line(4)));


end

