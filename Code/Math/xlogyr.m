function [ fnEval ] = xlogyr( x, y, z )
%XLOGYR Summary of this function goes here
%   Used to clean up cubeGrav

fnEval = x*log(y + radius(x,y,z));


end

