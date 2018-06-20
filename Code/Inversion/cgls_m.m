function  [x] = cgls_m(A, x0, b, max_iter, mu)
%
% This is the program to solve cgls
%
% Finds x = argmin_x { || A x - b ||_2^2 + mu ||x||_2^2 } 
% 
% ---------------------------
% This Program uses Matrices
% ---------------------------

 mu = sqrt(mu);
 x = x0;
 s  = b  - A*x;
 sr = 0. - mu*x;
 r = A'*s + mu*sr;
 p = r;
 q = A*p;
 qr= mu*p;
 
  for k = 1:max_iter
    alpha = r'*r/(q'*q+qr'*qr);
    x = x + alpha*p;
    s = s - alpha*q;
    sr = sr - alpha*qr;
    old = r'*r; 
    r = A'*s+mu*sr;
    beta = r'*r/old;
    p = r + beta*p;
    q = A*p;
    qr = mu*p;
   end;
    
 



