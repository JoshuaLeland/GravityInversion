function [ pFinal, iter ] = logBarrier( A, p0, pPlus, mu, WptWp, dObs )
%LOGBARRIER Takes the Matrix A, does a change of variables and will solve
%the system, change the variables back and return the final parameter and
%the number of iterations.

%Assign inital Variables
MAXIT = 100;
tol = 1e-5;
stop = 0;
iter = 0;
gamma = 0.925;
WmtWm = sparse((pPlus^2)*WptWp);
mOld =(1/pPlus)*p0;
G = A*pPlus;
d = dObs;
phiD = (G*mOld - d)'*(G*mOld - d);
phiM = mOld'*WmtWm*mOld;
logSum = sum(log(mOld));
%lambda = (phiD + mu*phiM)/2*logSum;
lambda = 1e6;
mLength=length(p0(:,1));
e = ones(mLength,1);
phiTotOld = phiD + mu*phiM -2*lambda*logSum;
%X1 = sparse(diag(1./mOld));
%X2 = sparse(diag(1./(mOld.^2)));

while(stop == 0)
    %Make dlog variables
     X1 = sparse(diag(1./mOld));
     X2 = sparse(diag(1./(mOld.^2)));
    
    %Get dD
    dD = G*mOld - d;
    
    %Calculate the step in m
   Top = G'*G + mu*WmtWm + lambda*X2;
    Bot = -G'*dD - mu*WmtWm*mOld + lambda*X1*e;
    dM = (Top)\(Bot);
    
    %Calculate the step modifier
    if(dM >= 0)
        B = 1;
    else
        newMin = 999;
        for k = 1 : mLength
            if (dM(k,1) < 0 && newMin > mOld(k,1)/abs(dM(k,1)))
                newMin=mOld(k,1)/abs(dM(k,1));
            end
        end
        B = newMin;
    end
    
    %Calcuate new parameter
    mNew = mOld + gamma*B*dM;
    
    %Calculate new lambda
    lambda = (1 - min([B,gamma]))*lambda;
    
    %Calculate new Objective functions
    phiD = (G*mNew - d)'*(G*mNew - d);
    phiM = mNew'*WmtWm*mNew;
    logSum = -2*lambda*sum(log(mNew));
    phiTotNew = phiD + mu*phiM + logSum;
    
    %Check stopping critera the log term contributes an insignificant
    %amount to the objective function and the change in objective function
    %is less than 1%
    if( abs(phiTotNew - phiTotOld)/abs(phiTotOld) <= 0.01 && abs(logSum)/abs(phiTotNew) < tol)
        stop = 1;
    end
    
    %Add iteration and check to see if maximum iterations has been reached.
    iter = iter + 1;
    if(iter >= MAXIT)
        stop = 1;
    end
    
    %Moving onto next iteration assign variables for new iteration
    phiTotOld = phiTotNew;
    mOld = mNew;
end

%Solution has converged, change the variables back and return inital
%parameter vector.
pFinal = pPlus*mNew;




end

