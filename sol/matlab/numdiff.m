function [gnum, Hnum] = numdiff(myfunc, x, par)
epsilon = par.epsilon;
len = length(x);
base = eye(len);
gnum = zeros(len,1);
Hnum = zeros(len,len);

for ii = 1:len
    [value_plus, grad_plus, ~] = myfunc(x+epsilon*base(:,ii),par);
    [value_minus, grad_minus, ~] = myfunc(x-epsilon*base(:,ii),par);
    gnum(ii) = (value_plus - value_minus) / (2*epsilon);
    Hnum(ii,:) = (grad_plus - grad_minus) / (2*epsilon);
end

end