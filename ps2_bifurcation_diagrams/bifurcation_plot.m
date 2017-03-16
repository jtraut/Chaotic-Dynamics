function bifurcation_plot(x0, m, l)
%x0 is initial x (population size)
%m is number of iterations 
%l suppresses the plotting of the first l points (transient)

%R is growth rate
R1 = 2.9;
R2 = 3.1; 
m = 5000;
l = 1000;

rRange = R1:.001:R2;
x = x0*ones(1, length(rRange));
i = 0;

for R = rRange
    i = i + 1;
    for n = 2:m
        x(n, i) = R*x(n-1, i)*(1 - x(n-1, i)); 
    end
end

%truncate to get end behavior 
x = x(l:end,:)

%plot for x(n) vs R
figure
plot(rRange, x, '.', 'MarkerSize', 1); 
title(['Graph of X(n) Versus R for m=' num2str(m) ' and l=' num2str(l)]);
xlabel('R');
ylabel('X(n)');

