%state vector x = [x y z]

function [f] = rossler(x)
    %natural frequency = sqrt(g/l)/2pi
    a = .398;
    b = 2;
    c = 4;
    f(1) = -1*(x(2) + x(3));
    f(2) = x(1) + a*x(2);
    f(3) = b + x(3)*(x(1) - c);
end 
