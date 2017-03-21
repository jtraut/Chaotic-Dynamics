function [L, index] = nearest_neighbor(x, z, n)
%x is current point on fiduciary trajectory
%z is the 1st half of the full trajectory used to find nearest neighbors
%n is length of z 

shortestD = 10000;
start = 1000; %keep search skewed towards x trajectory 
for i = start:n 
    %compute euclidean distance d between points x and z 
    if x ~= z{i} %the trajectory shouldn't cross like this but to be safe, chaos afterall
         d = norm(x - z{i});
    end
    if d < shortestD && d > 0
        shortestD = d;
        index = i;
    end 
end

L = shortestD;

end