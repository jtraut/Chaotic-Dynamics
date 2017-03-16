function variational_eqns(t0, h, n, x, F)
%h is the time step (deltaT)
%n is number of steps
%x is initial augmented state vector [[x y z] [&xx &xy &xz &yx &yy &yz &zx
%&zy &zz]]
%F is the derivative of the (lorenz) system 
t = t0;

fid = fopen('vartional_eqns_results.txt','wt'); %open file for writing

for i = 1:n
    
    fprintf(fid, 'Augmented state vector at time %.5f: ', t);
    fprintf(fid, '%.10f', x{i}(1));
    fprintf(fid, ' , ');
    fprintf(fid, '%.10f', x{i}(2));
    fprintf(fid, ' , ');
    fprintf(fid, '%.10f', x{i}(3));
    fprintf(fid, ' , ');    
    fprintf(fid, '%.10f', x{i}(4));
    fprintf(fid, ' , ');
    fprintf(fid, '%.10f', x{i}(5));
    fprintf(fid, ' , ');
    fprintf(fid, '%.10f', x{i}(6));
    fprintf(fid, ' , ');    
    fprintf(fid, '%.10f', x{i}(7));
    fprintf(fid, ' , ');
    fprintf(fid, '%.10f', x{i}(8));
    fprintf(fid, ' , ');
    fprintf(fid, '%.10f', x{i}(9));
    fprintf(fid, ' , ');    
    fprintf(fid, '%.10f', x{i}(10));
    fprintf(fid, ' , ');
    fprintf(fid, '%.10f', x{i}(11));
    fprintf(fid, ' , ');
    fprintf(fid, '%.10f', x{i}(12));    
    
    %RK4
    K1 = F(x{i});
    K2 = F(x{i} + h/2*K1);
    K3 = F(x{i} + h/2*K2);
    K4 = F(x{i} + h*K3);
    
    x{i+1} = x{i} + h*((K1 + 2*K2 + 2*K3 + K4)/6);
    
    t = t + h; 
    
    fprintf(fid, '\n');
    
end

x{i+1}
X = x{i+1};
evolved_var1 = X(4) + X(5) + X(6)
evolved_var2 = X(7) + X(8) + X(9)
evolved_var3 = X(10) + X(11) + X(12)
fclose(fid);

end