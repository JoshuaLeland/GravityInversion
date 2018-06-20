% %Testing the forward model for the Gravity Inversion
% clear all;
% close all;
% 
% xStart = 0;
% xEnd = 100;
% yStart = 0;
% yEnd = 100;
% zStart = 0.1;
% zEnd = 50.1;
% nx = 20;
% ny = 20;
% nz = 10;
% targetChiSq = 400;
% 
% %Make the Parameter  grid3D( xStart, xEnd, yStart, yEnd, zStart, zEnd, nx, ny, nz )
% [ paramGrid, dx, dy, dz ] = grid3D( xStart, xEnd, yStart, yEnd, zStart, zEnd, ny, ny, nz );
% 
% %Generate observation points (Increases in X then Y)
% [ Obsgrid2D1D ] = grid2D1DInbetween(20, 80, 20, 80, 20, 20 );
% Obsgrid2D1D(:,3) = 0;
% 
% %Generate the forward matrix
% [ ForwardMatrix ] = ForwardMatrix(Obsgrid2D1D, paramGrid);
% lengthDensity = length(ForwardMatrix(1,:));

%Generate generic denisty vector
Density = zeros(lengthDensity,1);

[ Density ] = paramAssign(40, 60, 40, 60, 10, 30, 1, paramGrid, Density );

%Get data for a flat uniform earth.
dObs = ForwardMatrix*Density;
dObscontour = onedtotwod( dObs,nx,ny );

dObsMax = max(dObs);

%Add 2% noise
dObs = dObs + 0.02*dObsMax*randn(20*20,1);
stddev = 0.02*dObsMax;

%Get a slice from the inital model
[ modelSlice ] = getsliceConstx( 51, paramGrid, Density );

%Move to 2D
[ densitySlice ] = onedtotwod( modelSlice,ny,nz );

%Plot Inital Data
figure(1);
subplot(2,2,1)
contourf(23:3:80,23:3:80,(dObscontour));
xlabel('X Distance');
ylabel('Y distance');
title('Inital Data');
colorbar;

subplot(2,2,2)
imagesc(5:5:100,5:5:50,(densitySlice));
set(gca,'YDir','reverse');
xlabel('Y Distance');
ylabel('Z distance');
title('Inital model');
colorbar;

z0 = 1;
b = 2;
%Run Depth Weighting Function. Just to show z0 works.
[ FzWeight, Wzv ] = depthWeight(xEnd,xStart,yEnd,yStart, zEnd, zStart, nx , ny, nz, z0, b, 2 );

%Generate Depth Weighing Matrix
Z  = sparse(genWz( z0, paramGrid, b ));

% %Make Alphas, holding all derivitives to be the same.

%Generating Derivitive Matrixies.

Dx = sparse(genDx( nx,ny,nz ));
Dy = sparse(genDy( nx,ny,nz ));
Dz = sparse(genDz( nx,ny,nz ));

% AlphaTable = logspace(-3,1,9);
% lengthAlpha = length(AlphaTable);
% chiSqFinal = zeros(lengthAlpha,1);

% figure(3);
% for j = 1 :lengthAlpha
%     Pick Alpha
%     alpha = AlphaTable(j);
%     
%     Generate each weighting matrix
%     Ws = alpha*sparse(sqrt(dx*dy*dz)*eye(lengthDensity)*Z);
%     Wx = sparse(sqrt(dy*dz/(2*dx))*Dx*Z);
%     Wy = sparse(sqrt(dy*dx/(2*dy))*Dy*Z);
%     Wz = sparse(sqrt(dy*dx/(2*dz))*Dz*Z);
% 
%     Generate Weighting function.
%     WtW = sparse(Ws'*Ws+Wx'*Wx+Wy'*Wy+Wz'*Wz);
% 
%     %Generate mu values.
% 
%     muTable = logspace(-1,2,15);
%     lengthmu = length(muTable);
%     chiSq = zeros(lengthmu,1);
% 
%     % Pick optimal mu
%     for i = 1 : lengthmu
%         %Make subplot and pick the alpha value.
%         mu = muTable(i);
%     
%         %Invert with for alpha value   
%         p = (ForwardMatrix'*ForwardMatrix + mu*WtW)\ForwardMatrix'*dObs;
% 
%         %Get predicted Data
%         dpred = ForwardMatrix*p;
%     
%         %Get error
%         error = dObs - dpred;
%     
%         chiSq(i,1) = (error'*error)/(stddev^2);
%     
%     end
% 
%     %Get Value with best chi sq
%     [~,optDampedInt] = min(abs(chiSq - targetChiSq));
%     optDamped = muTable(optDampedInt);
%     
%     %Invert for optimum Damping coefficant
%     p = (ForwardMatrix'*ForwardMatrix + optDamped*WtW)\ForwardMatrix'*dObs;
%     
%     chiSqFinal(j) = chiSq(optDampedInt,1);
%     
%     subplot(3,3,j);
%     modelSlice = getsliceConstx( 51, paramGrid, p );
%     densitySlice = onedtotwod( modelSlice,ny,nz );
%     
%     %plot Density slice into subplot
%     contourf(densitySlice);
%     set(gca,'YDir','reverse');
%     xlabel('Y Distance');
%     ylabel('Z distance');
%     title('Alpha Guess');
%     
% end
%Generate each weighting matrix
    alpha = 0.0005;
    Ws = alpha*sparse(sqrt(dx*dy*dz)*eye(lengthDensity)*Z);
    Wx = sparse(sqrt(dy*dz/(2*dx))*Dx*Z);
    Wy = sparse(sqrt(dy*dx/(2*dy))*Dy*Z);
    Wz = sparse(sqrt(dy*dx/(2*dz))*Dz*Z);

    %Generate Weighting function.
    WtW = sparse(Ws'*Ws+Wx'*Wx+Wy'*Wy+Wz'*Wz);
    
    muTable = logspace(2,4,30);
    lengthmu = length(muTable);
     chiSq = zeros(lengthmu,1);

%  %Pick optimal mu
%     for i = 1 : lengthmu
%         Make subplot and pick the alpha value.
%         mu = muTable(i);
%     
%         Invert with for alpha value   
%         p = (ForwardMatrix'*ForwardMatrix + mu*WtW)\ForwardMatrix'*dObs;
% 
%         Get predicted Data
%         dpred = ForwardMatrix*p;
%     
%         Get error
%         error = dObs - dpred;
%     
%         chiSq(i,1) = (error'*error)/(stddev^2);
%     
%     end
% 
%     
%     [~,optDampedInt] = min(abs(chiSq - targetChiSq));
%     optDamped = muTable(optDampedInt);
    optDamped = 1500;
    %Invert for optimum Damping coefficant
    p = (ForwardMatrix'*ForwardMatrix + optDamped*WtW)\ForwardMatrix'*dObs;
    modelSlice = getsliceConstx( 51, paramGrid, p );
    densitySlice = onedtotwod( modelSlice,ny,nz );
    
    figure(1);
    subplot(2,2,3)
    dObs = ForwardMatrix*p;
    dObscontour = onedtotwod( dObs,nx,ny );
    contourf(23:3:80,23:3:80,dObscontour);
    xlabel('X Distance');
    ylabel('Y distance');
    title('Predicted Data');
    colorbar;
    
    subplot(2,2,4)
    imagesc(5:5:100,5:5:50, densitySlice);
    set(gca,'YDir','reverse');
    xlabel('Y Distance');
    ylabel('Z distance');
    title('Recovered model');
    colorbar;
    
    
    