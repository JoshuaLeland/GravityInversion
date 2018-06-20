function [ Dz ] = genDz( nx,ny,nz )
%GENDY Summary of this function goes here
%   Detailed explanation goes here

Dz = zeros(nx*ny*nz, nx*ny*nz);
for i = 1 : nx*ny*nz
    if( nx*ny*nz - i < nx*ny)
        Dz(i,i) = 1;
    else
        Dz(i,i) = 1;
        Dz(i,i+nx*ny) = -1;
    end
end

end


