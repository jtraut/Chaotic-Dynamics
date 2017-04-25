function binary_system(x, m, n, F)
%x is the initial conditions of 2 masses [x1 y1 z1 x1' y1' z1' x2 y2 z2 x2' y2' z2']
%m is number of orbits
%n is number of steps per orbit 
%Uses two-body equations (F) to integrate the binary orbit 
t = 0;

fid = fopen('binary_system_results.txt','wt'); %open file for writing
%set up plot
figure;
hold on;
title('Two body binary orbit');
xlabel('x (normalized AU)');
ylabel('y (normalized AU)');

%keep track of the massses x,y trajectory
m1{1} = x{1}(1:3);
m2{1} = x{1}(7:9);

%calculate time step h given 2pi years per orbit 
h = 2*pi/n;

i = 0;
for j = 1:m
    for k = 1:n
        i = i + 1;
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
        m1{i+1} = x{i+1}(1:3);
        m2{i+1} = x{i+1}(7:9);
   
        %plot the 2 masses trajectories 
        plot3(m1{i}(1),m1{i}(2),m1{i}(3),'r');
        plot3(m2{i}(1),m2{i}(2),m2{i}(3),'b');
        pause(0.0000000001); %used to see the dynamic orbit from beginning to end
        t = t + h; 
        fprintf(fid, '\n');
    end
end

fclose(fid);

end 