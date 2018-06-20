function [ Grid, dx, dy, dz ] = grid3D( xStart, xEnd, yStart, yEnd, zStart, zEnd, nx, ny, nz )
%3DGRID Makes a 3D grid of Volumes with the lower and higher bounds for
%each Volume and dimension.
% Vectorizes the 3d space into a 1D vector. Increases in x then y then z

%Get Lengths for each direction
xLength = xEnd - xStart;
yLength = yEnd - yStart;
zLength = zEnd - zStart;

%Get step in each direction
dx = xLength/nx;
dy = yLength/ny;
dz = zLength/nz;

%Initialize Grid
Grid = zeros(nx*ny*nz,6);

for i = 1 :nz
    for j = 1 :ny
        for k = 1:nx
            Grid(nx*ny*(i-1)+nx*(j-1)+k,1) = xStart + dx*(k-1); %Lower x
            Grid(nx*ny*(i-1)+nx*(j-1)+k,2) = xStart + dx*(k); %Upper x
            Grid(nx*ny*(i-1)+nx*(j-1)+k,3) = yStart + dy*(j-1); % Lower y
            Grid(nx*ny*(i-1)+nx*(j-1)+k,4) = yStart + dy*(j); %Upper y
            Grid(nx*ny*(i-1)+nx*(j-1)+k,5) = zStart + dz*(i-1); %Lower Z
            Grid(nx*ny*(i-1)+nx*(j-1)+k,6) = zStart + dz*(i); %Upper Z   
        end
    end
end




end

