function [ Fz, Wz ] = depthWeight(x2,x1,y2,y1, z2, z1, nx , ny, nz, z0, b, fignum )
%DEPTHWEIGHT Summary of this function goes here
%   Detailed explanation goes here

%Finding the cell dimension
dz = (z2 - z1)/nz;
dy = (y2 - y1)/ny;
dx = (x2 - x1)/nx;

Fz = zeros(nz,2);
Wz = zeros(nz,2);
%Looking at the decay for a cell of one with depth. Depths are measured to
%the center of the cell.
for i = 1 : nz
   %cubeGrav(x0,x1,x2,y0,y1,y2,z0,z1,z2)
   %cubeGrav(0,-dx/2,dx/2,0,-dy/2,dy/2,0,(i-1)*dz+z1,i*dz+z1)
    Fz(i,1) = cubeGrav2( i*dz+z1, (i-1)*dz+z1, dy/2, -dy/2, dx/2, -dx/2);
    Fz(i,2) = ((i-1)*dz)+ dz/2 +z1;
end

%Normalize the Function kernal
Fz(:,1)=Fz(:,1)/Fz(1,1);

%Plotting the decay weighting function on top of the decay kernals.
for i = 1 : nz
    Wz(i,1) = 1/((Fz(i,2) + z0)^(b));
    Wz(i,2) = ((i-1)*dz)+ dz/2 +z1;
end

%Normalize the weighting matrix.
Wz(:,1)=Wz(:,1)/Wz(1,1);


figure(fignum);
plot(Fz(:,2), Fz(:,1),'k');
hold on;
plot(Wz(:,2), Wz(:,1),'b');

xlabel('Depth (Z units)');
ylabel('W(z)^2 or Fz(Z) (Normalized)');
legend('Data kernal','Weighting function');


end

