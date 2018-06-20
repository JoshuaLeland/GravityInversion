function [ Dx ] = genDx( nx,ny,nz )
%GENDX Summary of this function goes here

Dx = zeros(nx*ny*nz, nx*ny*nz);
for i = 1 : nx*ny*nz
    if( mod(i,nx) == 0)
        Dx(i,i) = 1;
    else
        Dx(i,i) = 1;
        Dx(i,i+1) = -1;
    end
end

end

