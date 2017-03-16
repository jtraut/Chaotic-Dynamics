%state vector x = [x y z &xx &xy &xz &yx &yy &yz &zx
%&zy &zz]

function [f] = lorenz_variational(x)
    %natural frequency = sqrt(g/l)/2pi
    a = 16;
    r = 45;
    b = 4;
    f(1) = a*(x(2) - x(1));
    f(2) = r*x(1) - x(2) - x(1)*x(3);
    f(3) = x(1)*x(2) - b*x(3);
    
    %now the variations
    f(4) = a*(x(5)-x(4));
    f(5) = (r-x(3))*x(4)-x(5)-x(1)*x(6);
    f(6) = x(2)*x(4)+x(1)*x(5)-b*x(6);
    f(7) = a*(x(8)-x(7));
    f(8) = (r-x(3))*x(7)-x(8)-x(1)*x(9);
    f(9) = x(2)*x(7)+x(1)*x(8)-b*x(9);
    f(10) = a*(x(11)-x(10));
    f(11) = (r-x(3))*x(10)-x(11)-x(1)*x(12);
    f(12) = x(2)*x(10)+x(1)*x(11)-b*x(12);
    
end 
