function [ fnEval ] = ylogxr(x,y,z )
%YLOGXR Summary of this function goes here
%   Used to clean up cubeGrav.m

fnEval = y*log(x + radius(x,y,z));

end

