function [ Fz ] = numGrav(z2,z1,nz,y2,y1,ny,x2,x1,nx )
%numGrav will numerically calculate the gravitational attraction of a cube
%by using a point mass approximation.  The number of point masses in each
%direction is controlled by nz, ny, nx.


dx = (x2 - x1)/nx;
dy = (y2 - y1)/ny;
dz = (z2 - z1)/nz;
dv = dx*dy*dz;

Fz = 0;
for k = 1 : nz
    for j = 1 : ny
        for i = 1 : nx
            z = z1 + ((k-1) + 0.5)*dz;
            r = radius( x1+((i-1) + 0.5)*dx , y1+((j-1) + 0.5)*dy , z1+((k-1) + 0.5)*dz );
            Fz = Fz + dv*z/(r^3);
        end
    end
end

end

