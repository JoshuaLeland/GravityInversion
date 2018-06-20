function [ Dy ] = genDy( nx,ny,nz )
%GENDY Summary of this function goes here
%   Detailed explanation goes here

Dy = zeros(nx*ny*nz, nx*ny*nz);

    for i = 1 : nx*ny*nz
        if(nx*ny - mod(i,nx*ny) < nx)
            Dy(i,i) = 1;
        elseif(mod(i,nx*ny) == 0)
            Dy(i,i) = 1;
        else
            Dy(i,i) = 1;
            Dy(i,i+nx) = -1;
        end
    end

end


