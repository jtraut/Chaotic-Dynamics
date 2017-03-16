%state vector x = [x y z]

function [f] = lorenz(x)
    %natural frequency = sqrt(g/l)/2pi
    a = 16;
    r = 45;
    b = 4;
    f(1) = a*(x(2) - x(1));
    f(2) = r*x(1) - x(2) - x(1)*x(3);
    f(3) = x(1)*x(2) - b*x(3);
end 
