function [ paramSlice ] = getsliceConstx( xCoord, paramGrid, paramVect )
%GETSLICECONSTX Summary of this function goes here
%   Since increasing in y then z the density will incease in y first then z
%   so ny, and nz are required

lengthParam = length(paramGrid(:,1));

j = 1;
for i = 1 : lengthParam
    if(xCoord >= paramGrid(i,1) && xCoord <=paramGrid(i,2))
        paramSlice(j,1) = paramVect(i,1);
        j =j +1;
    end
end


end

