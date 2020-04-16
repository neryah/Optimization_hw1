function [f,g,H] = f1(x,par)
A = par.A;
[phi_f, phi_g, phi_H] = par.phi(A*x);

%%%%%%%%%% value %%%%%%%%%%%
f = phi_f;

%%%%%%%%% gradient %%%%%%%%%
g = (A.') * phi_g;

%%%%%%%%% hessian %%%%%%%%%%
H = (A.') * phi_H * A;
end