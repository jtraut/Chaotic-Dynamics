function [Lprime, xIndex, zIndex] = find_Lprime(x, z, xIndex, zIndex, n, N, epsilon)
%x is fiduciary trajectory, with xIndex of where to start in time
%z is 1st half of trajectory of which to find neighbors, starting at point zIndex 
%n is length of z trajectory 
%N is length of x
%epsilon is knob for finding L' of nearest neighbors 

d = -1;
while d < epsilon && xIndex < N
    zIndex = zIndex + 1;
    xIndex = xIndex + 1;
    if zIndex >= n %checked here to still allow xIndex to grow even at end of z
        break; 
    end 
    xPt = x{xIndex};
    zPt = z{zIndex};
    %calc euclidean distance 
    d = norm(xPt - zPt);
end

if d > epsilon
    Lprime = d;
else
    Lprime = 0; %acceptable value not found so set to 0 to exclude
end 

end