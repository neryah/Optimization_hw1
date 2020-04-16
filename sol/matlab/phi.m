% gets n dimensional vector x and returns value, gradient and hessian of 
% sin(multiplication of x ellements) 
function [f,g,H] = phi(x)
%%%%%%%%%%%%%%%%% Value %%%%%%%%%%%%%%%%
f = sin(prod(x));

%%%%%%%%%%%%%%%% Gradient %%%%%%%%%%%%%%
len = length(x);
dprod = zeros(len,1);

for ii = 1:len % calculates dprod
    temp1 = x(ii);
    x(ii) = 1;
    dprod(ii) = prod(x);
    x(ii) = temp1;
end

g = cos(prod(x)) * dprod; % gradient calculation 

%%%%%%%%%%%%%%%%% Hessian %%%%%%%%%%%%%%
ddprod = zeros(len,len);

for ii = 1:len % calculates ddprod
    temp1 = x(ii);
    x(ii) = 1;
    for jj = 1: len
        ddprod(ii, jj) = 0;
        if (ii ~= jj)    
            temp2 = x(jj);
            x(jj) = 1;
            ddprod(ii, jj) = prod(x);
            x(jj) = temp2;
        end
    end
    x(ii) = temp1;
end

H = dprod * transpose(-sin(prod(x)) * dprod) + cos(prod(x)) * ddprod;
end