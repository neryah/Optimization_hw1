function [f,g,H] = f2(x,par)
[phi_f, phi_g, phi_H] = par.phi(x);
[h_f, h_g, h_H] = par.h(phi_f);

%%%%%%%%%% value %%%%%%%%%%%
f = h_f;

%%%%%%%%% gradient %%%%%%%%%
g = h_g * phi_g;

%%%%%%%%% hessian %%%%%%%%%%
H = h_H * phi_g * (phi_g.') + h_g * phi_H;
end