function traj = runge_kutta(t0, h, n, x, F)
%h is the time step (deltaT)
%n is number of steps
%x is initial state vector [theta, omega]
%F is the derivative of the system 
t = t0;

%return trajectory [t, x, y]
traj{1} = [t x{1}];

fid = fopen('RK4_results.txt','wt'); %open file for writing

%plot for state space theta vs omega
%figure
%hold on;
%view(3)
%title(['Chaotic attractor in Lorenz system for IC = [' num2str(x{1}(1)) ', ' num2str(x{1}(2)) ', ' num2str(x{1}(3)) '] (Nonadaptive)']);
%xlabel('X');
%ylabel('Y');
%zlabel('Z');


for i = 1:n-1
    
    fprintf(fid, 'State space vector at time %.5f: ', t);
    fprintf(fid, '%.10f', x{i}(1));
    fprintf(fid, ' , ');
    fprintf(fid, '%.10f', x{i}(2));
  %  fprintf(fid, ' , ');
  %  fprintf(fid, '%.10f', x{i}(3));
    
 %   plot3(x{i}(1), x{i}(2), x{i}(3), '.', 'MarkerSize', 2); 
 %   plot(x{i}(1), x{i}(2), '.', 'MarkerSize', 4);   
    %RK4
    K1 = F(x{i}, t);
    K2 = F(x{i} + h/2*K1, t);
    K3 = F(x{i} + h/2*K2, t);
    K4 = F(x{i} + h*K3, t);
    
    x{i+1} = x{i} + h*((K1 + 2*K2 + 2*K3 + K4)/6);
    
    t = t + h; 

    traj{i+1} = [t x{i+1}];
    
    fprintf(fid, '\n');
    
end

%traj{i}
fclose(fid);

end