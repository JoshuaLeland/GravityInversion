%Testing the forward model for the Gravity Inversion
clear all;
close all;

%Make the Parameter  grid3D( xStart, xEnd, yStart, yEnd, zStart, zEnd, nx, ny, nz )
[ paramGrid, dx, dy, dz ] = grid3D( 0, 200, 0, 200, 0.1, 100.1, 10, 10, 5 );

% %Generate observation points (Increases in X then Y)
[ Obsgrid2D1D ] = grid2D1DInbetween(95, 105, 95, 105, 10, 10 );
Obsgrid2D1D(:,3) = 0;

%Generate the forward matrix
[ ForwardMatrix ] = ForwardMatrix(Obsgrid2D1D, paramGrid);
lengthDensity = length(ForwardMatrix(1,:));

%Generate generic denisty vector
Density = ones(lengthDensity,1);

%Get data for a flat uniform earth.
dObs = ForwardMatrix*Density;
dObscontour = onedtotwod( dObs,10,10 );

figure(1);
imagesc((dObscontour));


