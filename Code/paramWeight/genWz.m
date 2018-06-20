function [ Wz ] = genWz( z0, paramGrid, beta )
%GENWZ Summary of this function goes here
%   Detailed explanation goes here

lengthParam = length(paramGrid(:,1));

Wz = sparse(zeros(lengthParam,lengthParam));

for i = 1 : lengthParam
    z = paramGrid(i,5) + (paramGrid(i,6) - paramGrid(i,5))/2; 
    Wz(i,i) = 1/((z0 + z)^(beta/2));
end

