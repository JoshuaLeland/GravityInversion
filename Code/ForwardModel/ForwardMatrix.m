function [ ForwardMatrix ] = ForwardMatrix(ObsPoints, paramCoords)
%FORWARDMATRIX takes in the Observation point and the coordinates of the
%parmeters to generate the sensitivity matrix.
% Obs points are: x, y, z
% paramCoors are: in lower x, upper x, lower y, upper y, lower z, upper z

lengthObs = length(ObsPoints(:,1));
lengthParam = length(paramCoords(:,1));
ForwardMatrix = zeros(lengthObs, lengthParam);

for i = 1 : lengthObs
    for j = 1 : lengthParam
%         %Getting the length from the observation point to the parameter.
%         z2 = paramCoords(j,6) - ObsPoints(i,3);
%         z1 = paramCoords(j,5) - ObsPoints(i,3);
%         y2 = paramCoords(j,4) - ObsPoints(i,2);
%         y1 = paramCoords(j,3) - ObsPoints(i,2);
%         x2 = paramCoords(j,2) - ObsPoints(i,1);
%         x1 = paramCoords(j,1) - ObsPoints(i,1);
%         
% %          if (abs(y2) < abs(y1) || abs(x2) < abs(x1))
% %              error('Somethins is wrong here')
% %          end
%         
%         %Calculate values and put into the matrix.  
%         ForwardMatrix(i, j) = cubeGrav2( z2, z1, y2, y1, x2, x1);
                   
          ForwardMatrix(i,j) =cubeGrav(ObsPoints(i,1),paramCoords(j,1),...
          paramCoords(j,2),ObsPoints(i,2),paramCoords(j,3),paramCoords(j,4),...
          ObsPoints(i,3),paramCoords(j,5),paramCoords(j,6));
        
    end
end


end

