function [ grid2D1D ] = grid2D1DInbetween(xStart, xEnd, yStart, yEnd, nx, ny )
%GRID2D Used to genetate quick 2d grids in a 1D vector, 
%but puts the points in the middle spacing 

%Get set lengths
dx=(xEnd - xStart)/nx;
dy=(yEnd - yStart)/ny;

%Initialize grid.
grid2D1D = zeros(nx*ny,1);

for i = 1 : ny
    for j = 1 : nx
        grid2D1D(nx*(i-1)+j,1) = xStart + ((j-1) + 0.5 )*dx;
        grid2D1D(nx*(i-1)+j,2) = yStart + ((i-1) + 0.5 )*dy;
    end
end


end

