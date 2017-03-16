function logistic_map(R, x0, m)
%R is growth rate
%x0 is initial x (population size)
%m is number of iterations 

x = []; %array to store population values at time x(1) ... x(n) 
n = []; %timestamps 
x(1) = x0; %initial condition 
n(1) = 0;

R = 3.6;
m = 100;
x(1) = 0.2;

Xn1 = []; Xn2 = [];
Xn1(1) = R*x(1)*(1 - x(1)); %store x(n+1)
Xn2(1) = R*Xn1(1)*(1 - Xn1(1)); %store x(n+2)

for i = 2:m
    x(i) = R*x(i-1)*(1 - x(i-1));
    n(i) = i;
    
    Xn1(i) = R*x(i)*(1 - x(i));
    Xn2(i) = R*Xn1(i)*(1 - Xn1(i));
    
end 
 
%plot for x(n) vs n
figure
plot(n, x, '.'); 
title(['Graph of X(n) Versus n for R=' num2str(R) ', Xo=' num2str(x0) ' and m=' num2str(m)]);
xlabel('n');
ylabel('X(n)');

%plot for x(n+1) vs x(n)
figure
plot(x, Xn1, '.');
title(['Graph of X(n+1) Versus X(n) for R=' num2str(R) ', Xo=' num2str(x0) ' and m=' num2str(m)]);
xlabel('X(n)');
ylabel('X(n+1)');

%plot for x(n+2) vs x(n)
figure
plot(x, Xn2, '.');
xlabel('X(n)');
ylabel('X(n+2)');
title(['Graph of X(n+2) Versus X(n) for R=' num2str(R) ', Xo=' num2str(x0) ' and m=' num2str(m)]);


end