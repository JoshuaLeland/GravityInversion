function [ vmodel ] = onedtotwod( params,nx,ny )
%ONEDTOTWOD Summary of this function goes here
%   Detailed explanation goes here
vmodel = zeros(ny,nx);
for i = 1 : ny
    for j = 1 : nx
        vmodel(i,j) = params((i-1)*nx + j);
    end    
end

end

