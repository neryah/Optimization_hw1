function [] = main(x)
%% Defenitions
len = length(x);
A = magic(3);
epsilon = eps^(1/3) * max(abs(x));
par = struct('A',A,'epsilon',epsilon,'phi',@phi,'h',@h);

x_values_massege = [' (x = [' num2str(x(1)) ' ' num2str(x(2)) ' ' num2str(x(3)) '])']
%% Calculations
%%%%%%%%% analitic %%%%%%%%%
[~ ,g_ana1, H_ana1] = f1(x,par);   
[~ ,g_ana2, H_ana2] = f2(x,par); 

%%%%%%%%% numeric %%%%%%%%%%
[g_num1, H_num1] = numdiff(@f1,x,par);
[g_num2, H_num2] = numdiff(@f2,x,par);

%% Plot Errors
% 1. gradient comparison
figure(1);
subplot(1,2,1) %f1
plot(g_num1-g_ana1,'*');
title(['Gradient of f1 comparison' x_values_massege]);
xlabel('Error'); ylabel('Index');
xlim([0,len+1]);
grid on

subplot(1,2,2) %f2
plot(g_num2-g_ana2,'*');
title(['Gradient of f2 comparison' x_values_massege]);
xlabel('Error'); ylabel('Index');
xlim([0,len+1]);
grid on

% 2. Hessian comparison
figure(2);
subplot(1,2,1); %f1
imagesc(H_num1-H_ana1);
title(['Hessian of f1 comparison' x_values_massege]);
xlabel('Row Index'); ylabel('Column Index');

subplot(1,2,2); %f2
imagesc(H_num2-H_ana2);
title(['Hessian of f2 comparison' x_values_massege]);
xlabel('Row Index'); ylabel('Column Index');

%% Multiple epsilons
epsilon = logspace(-16,2,34);
max_g_err = zeros(length(epsilon),2);
max_H_err = zeros(length(epsilon),2);

for ii = 1:length(epsilon)
    par = struct('A',A,'epsilon',epsilon(ii),'phi',@phi,'h',@h);
    %%%%%%%%% analitic %%%%%%%%%
    [~ ,g_ana1, H_ana1] = f1(x,par);   
    [~ ,g_ana2, H_ana2] = f2(x,par); 

    %%%%%%%%% numeric %%%%%%%%%%
    [g_num1, H_num1] = numdiff(@f1,x,par);
    [g_num2, H_num2] = numdiff(@f2,x,par);
    
    max_g_err(ii,:) = [max(abs(g_num1-g_ana1)),max(abs(g_num2-g_ana2))];
    max_H_err(ii,:) = [max(max(abs(H_num1-H_ana1))),max(max(abs(H_num2-H_ana2)))];
end

%% Plot Infinity Norm Errors 
% Gradient
figure(3);
subplot(1,2,1) %f1
loglog(epsilon,max_g_err(:,1));
title(['f1 Max Gradient Error for different epsilons' x_values_massege]);
xlabel('Epsilon'); ylabel('Error');
grid on
[~,ind] = min(max_g_err(:,1));
legend(['minimal value epsilon = '  num2str(epsilon(ind))]);

subplot(1,2,2) %f2
loglog(epsilon,max_g_err(:,2));
title(['f2 Max Gradient Error for different epsilons ' x_values_massege]);
xlabel('Epsilon'); ylabel('Error');
grid on
legend(['minimal value epsilon = '  num2str(epsilon(ind))]);

% Hessian
figure(4);
subplot(1,2,1) %f1
loglog(epsilon,max_H_err(:,1));
title(['f1 Max Hessian Error for different epsilons' x_values_massege]);
xlabel('Epsilon'); ylabel('Error');
grid on
legend(['minimal value epsilon = '  num2str(epsilon(ind))]);

subplot(1,2,2) %f2
loglog(epsilon,max_H_err(:,2));
title(['f2 Max Hessian Error for different epsilons ' x_values_massege]);
xlabel('Epsilon'); ylabel('Error');
grid on
legend(['minimal value epsilon = '  num2str(epsilon(ind))]);
end