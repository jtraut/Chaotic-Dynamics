function runge_kutta_portrait(t0, h, n, x, F)
%t0 is starting time
%h is the time step (deltaT)
%n is number of steps
%x is initial state vector
%F is the derivative of the system 
t = t0;
IC = x;
a = -10;
b = 10;

fid = fopen('RK4_results.txt','wt'); %open file for writing

%plot for state space theta vs omega
figure
hold on;

title(['Graph of state space portrait with h = ' num2str(h)]);
xlabel('theta (O) mod 2pi');
%xlabel('theta (O)');
ylabel('omega (w)');

for j = 1:250
    IC{j} = x{1};
    t = t0;
    for i = 1:n

        fprintf(fid, 'State space vector at time %.4f: ', t);
        fprintf(fid, '%.10f', x{i}(1));
        fprintf(fid, ' , ');
        fprintf(fid, '%.10f', x{i}(2));

        %plot(x{i}(1), x{i}(2), '.', 'MarkerSize', 1); 
        
        %for questions 5+, use theta mod 2pi
        plot(mod(x{i}(1), 2*pi), x{i}(2), '.', 'MarkerSize', 1); 
       
        %RK4
        K1 = F(x{i}, t);
        K2 = F(x{i} + h/2*K1, t);
        K3 = F(x{i} + h/2*K2, t);
        K4 = F(x{i} + h*K3, t);

        x{i+1} = x{i} + h*((K1 + 2*K2 + 2*K3 + K4)/6);

        t = t + h; 

        fprintf(fid, '\n');

    end
    new = 0;
    match = 0;
    while new == 0
        x{1} = [a+(b-a).*rand(1,1), a+(b-a).*rand(1,1)];
        for q = 1:j
            if x{1} == IC{q}
                match = 1;
            end 
        end
        if match == 0  
            new = 1;
        end 
    end
   
end 

fclose(fid);

end