%state vector for RK4 x = [theta omega]

function [f] = F_RK4(x, t)
    %natural frequency = sqrt(g/l)/2pi
    nf = 1.575; %natural frequency 
    alpha = 2.55*nf;
    A = .92;  
    m = .1;
    l = .1;
    beta = .25;
    g = 9.8;
    f(1) = x(2);
    f(2) = (A*cos(alpha*t) - beta*l*x(2) - m*g*sin(x(1)))/(m*l);
end 
