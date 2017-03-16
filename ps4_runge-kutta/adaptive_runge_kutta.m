function adaptive_runge_kutta(t0, h, n, x, F)
%t0 is starting time
%h is the time step (deltaT)
%n is number of steps
%x is initial state vector
%F is the the system 
t = t0;
h0 = h;
i = 1;
fid = fopen('Adaptive_RK4_results.txt','wt'); %open file for writing

%plot for state space
figure(1)
hold on;
view(3);
title(['Chaotic attractor in Lorenz system for IC = [' num2str(x{1}(1)) ', ' num2str(x{1}(2)) ', ' num2str(x{1}(3)) '] (Adaptive RK4)']);
xlabel('X');
ylabel('Y');
zlabel('Z'); 

errTol = 0.01;

%for i = 1:n
while t <= h0*n
   
    fprintf(fid, 'State space vector at time %.5f: ', t);
    fprintf(fid, '%.10f', x{i}(1));
    fprintf(fid, ' , ');
    fprintf(fid, '%.10f', x{i}(2));
    fprintf(fid, ' , ');
    fprintf(fid, '%.10f', x{i}(3)); 
    
    plot3(x{i}(1), x{i}(2), x{i}(3), 'r.', 'MarkerSize', 4); 
    
    %RK4 for h
    K1 = F(x{i});
    K2 = F(x{i} + h/2*K1);
    K3 = F(x{i} + h/2*K2);
    K4 = F(x{i} + h*K3);
    
    x{i+1} = x{i} + h*((K1 + 2*K2 + 2*K3 + K4)/6);
    
    %RK4 for h/2 
    K1 = F(x{i});
    K2 = F(x{i} + h/4*K1);
    K3 = F(x{i} + h/4*K2);
    K4 = F(x{i} + h/2*K3);
    
    x2 = x{i} + h/2*((K1 + 2*K2 + 2*K3 + K4)/6);
    
    K1 = F(x2);
    K2 = F(x2 + h/4*K1);
    K3 = F(x2 + h/4*K2);
    K4 = F(x2 + h/2*K3);
    
    x2 = x2 + h/2*((K1 + 2*K2 + 2*K3 + K4)/6);
    
    deltaX = x2 - x{i+1};
    upper = abs(max(deltaX));
    lower = abs(min(deltaX));
    if upper > lower
        error = upper;
    else
        error = lower;
    end 
        
    t = t + h;
    
    x{i+1} = x2;
    
    if error == 0
        h = h; %keep current timestamp and dont divide by 0
    elseif error >= errTol
        h = h*abs(errTol/error)^.2;
    end
    
    fprintf(fid, '\n');
    
    i = i+1;
    
end

fclose(fid);

end