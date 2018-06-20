function [ Fz ] = blakelyGrav( x0,x1,x2,y0,y1,y2,z0,z1,z2 )
%BLAKELYGRAV Summary of this function goes here
%   Following blakely 1995 fortran code --Revise to make more sense later.
%   Solution will only solve in first quadrant.  Will need to find the
%   equivilent problem in 1st quadrant.

%Shift points relative to the origin
x(1) = x0 - x1;
x(2) = x0 - x2;
y(1) = y0 - y1;
y(2) = y0 - y2;
z(1) = z0 - z1;
z(2) = z0 - z2;
Fz = 0;
isign(1) = -1;
isign(2) = 1;
for i = 1 : 2
    for j = 1 : 2
        for k = 1 : 2
            muijk = isign(i)*isign(j)*isign(k);
            rijk = radius( x(i),y(j),z(k) );
            invtan = atan((x(i)*y(j))/(rijk*z(k)));
            if (invtan <= 0 )
                invtan = invtan + 2*pi;
            end
            term1 = rijk + y(j);
            term2 = rijk + x(i);
            if( term1 < 0 || term2 < 0)
                error(' Bad Field point ');
            end
            logterm1 = log(term1);
            logterm2 = log(term2);
            Fz = Fz + muijk*(z(k)*invtan-x(i)*logterm1-y(j)*logterm2);
        end
    end
end
    




end

