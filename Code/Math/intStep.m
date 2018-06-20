function [ outF ] = intStep(x,y,z)
%INTSTEP intermediate step for the grav calculation
%   Detailed explanation goes here

outF = xlogyr(x,y,z) + ylogxr(x,y,z) - zasin(x,y,z);
end

