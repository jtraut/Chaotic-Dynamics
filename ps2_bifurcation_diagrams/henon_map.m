function henon_map(b, m, l)
%x0 is initial x (population size)
%m is number of iterations 
%l suppresses the plotting of the first l points (transient)

a1 = .363;
a2 = .365; 
m = 4000;
l = 3000;
b = .3;

aRange = a1:.00001:a2;
x = zeros(1, length(aRange));
y = zeros(1, length(aRange));
i = 0;

for a = aRange
    i = i + 1;
    for n = 2:m
        x(n, i)=1+y(n-1, i)-a*(x(n-1, i))^2;
        y(n, i)=b*x(n-1, i);
    end
end

%truncate to get end behavior 
x = x(l:end,:);

%plot for x(n) vs R
figure
plot(aRange, x, '.', 'MarkerSize', 1); 
title(['Graph of X(n) Versus a for m=' num2str(m) ' and l=' num2str(l)]);
xlabel('a');
ylabel('X(n)');