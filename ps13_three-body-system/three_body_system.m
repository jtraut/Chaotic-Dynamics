function three_body_system(x, n, F)
%x is the initial conditions of 3 masses [x1 y1 z1 x1' y1' z1' x2 y2 z2 x2' y2' z2']
%n is number of steps 
%Uses three-body equations (F) to integrate the binary orbit 
t = 0;

%set up plot
figure;
hold on;
title('Three body system');
xlabel('x');
ylabel('y');
zlabel('z');
%keep track of the massses x,y trajectory
m1{1} = x{1}(1:3);
m2{1} = x{1}(7:9);
m3{1} = x{1}(13:15);
%calculate initial time step h
h = 2*pi/1000;

i = 0; errTol = 0.0005;

for k = 1:n
    i = i + 1;  

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

    x{i+1} = x2;

    if error == 0
        h = h; %keep current timestamp and dont divide by 0
    elseif error >= errTol
        h = h*abs(errTol/error)^.2;
    end

    x{i+1} = x{i} + h*((K1 + 2*K2 + 2*K3 + K4)/6);
    m1{i+1} = x{i+1}(1:3);
    m2{i+1} = x{i+1}(7:9);
    m3{i+1} = x{i+1}(13:15);
    %plot the 2 masses trajectories 
    plot3(m1{i}(1),m1{i}(2),m1{i}(3),'r');
    plot3(m2{i}(1),m2{i}(2),m2{i}(3),'b');
    plot3(m3{i}(1),m3{i}(2),m3{i}(3),'g');
    %pause(0.0000000001); %used to see the dynamic orbit from beginning to end
    t = t + h; 

end


end 