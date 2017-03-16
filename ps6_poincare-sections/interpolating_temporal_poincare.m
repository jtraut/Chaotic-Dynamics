function interpolating_temporal_poincare(T, traj)
%a simple temporal Poincare section 
%T is the natural frequency 
%traj is the fixed state space of the system [t, theta, omega]

t = traj{1}(1); %the starting time

[~, columns] = size(traj);
trajLength = columns;

%natural period T = 1/f where f = sqrt(g/l)/(2pi) == 0.634697562594

endTime = traj{trajLength}(1);

tol_cycles = int64((endTime+T - t) / T);
E = t:T:endTime;

x_prev = traj{1};

j = 0;
k = 1;

%plot for Poincare section of theta vs omega
figure;
hold on;
title(['              Poincare section of a pendulum with IC = [' num2str(traj{1}(2)) ', ' num2str(traj{1}(3)) '] (chaotic)']);
xlabel('Theta mod 2PI');
ylabel('Omega');
for i = 2:trajLength
  %  E = i*T %surface of section E : t = nT0 
    x = traj{i};
    time1 = x_prev(1);
    time2 = x(1);
    
    %find valid section for the current time of trajectory 
    while E(k) < time1 && k < tol_cycles
        k = k + 1;
    end 

    if k > tol_cycles
        break
    end 
    %check if theres a point on the section
    if time1 < E(k) && E(k) <= time2
        j = j + 1;
        dx = x - x_prev;
        dt = (E(k)-time1)/dx(1);
        points = x_prev(2:end) + dx(2:end)*dt;
        section_pts{j} = [x_prev(1)+dt points];
        %(Theta mod 2pi) vs Omega
        plot(mod(section_pts{j}(2), 2*pi), section_pts{j}(3), '.', 'MarkerSize', 5);
        %plot(section_pts{j}(2), section_pts{j}(3), '.', 'MarkerSize', 5);
    end 
    
    x_prev = x;
end 

end 