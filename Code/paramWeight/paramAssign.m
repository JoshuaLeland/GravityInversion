function [ paramVect ] = paramAssign(xLow, xHigh, yLow, yHigh, zLow, zHigh, value, paramGrid, paramVect )
%PARAMASSIGN will put the assigned value into the Paramvect with the given
%bounds. Indexes in paramVect are in between the values in paramGrid.
%   Simple if statement, to do this, equality is included. Values already
%   in paramVect will be overridden.

lengthParam = length (paramVect(:,1));

for i = 1 : lengthParam
    if(paramGrid(i,1) >= xLow && paramGrid(i,2) <=xHigh && paramGrid(i,3) >= yLow...
        && paramGrid(i,4) <=yHigh && paramGrid(i,5) >= zLow && paramGrid(i,6) <=zHigh)
        paramVect(i,1) = value;
    end
end
