function lambda = wolf(dataPath)
%Implementation of Wolf's algorithm for computing Lyapunov exponents
%Input: data set in full state-space form (time, x, y, z) from Lorenz system
%Output: biggest Lyapunov exponent (lambda)

data = fopen(dataPath);
%get length of file
allText = textscan(data,'%s','delimiter','\n');
numberOfLines = length(allText{1});
fclose(data);

n = numberOfLines;

data = fopen(dataPath);
z = {}; 
x = {};
j = 0; k = 0;
for i = 1:n
    %store the trajectory data to be accessible 
    line = fgetl(data);
    splitData = strsplit(line);
    X = str2double(splitData(2));
    Y = str2double(splitData(3));
    Z = str2double(splitData(4));
    %first half of the trajectory to compare fiduciary to
    if i < (n/2 - 9) %leaving out 10 pts to not take a 'neighbor' that comes right before in time
        k = k + 1;
        z{k} = [X Y Z];
        if i == 1
            time1 = str2double(splitData(1));
        elseif i == 2
            time2 = str2double(splitData(1));
            deltaT = time2 - time1;    
        end 
    elseif i > n/2
        %beginning of fiduciary trajectory
        j = j + 1;
        x{j} = [X Y Z];
    end     
end 
fclose(data); 

L = []; Lprime = [];
xIndex = 1; m = 0; 
n = k; %length of z trajectory (about first half of trajectory)
N = j; %length of fiduciary trajectory 

while xIndex < N - 1
     m = m + 1; 
    %find x(t) nearest neighbor z(t) and distance L 
    [L(m), zIndex] = nearest_neighbor(x{xIndex}, z, n);
    
    %scale epsilon according to current nearest neighbor distance  
    epsilon = L(m) + L(m)/4; 
    
    %follow difference traj forward in time until d > epsilon (find Lprime)
    [Lprime(m), xIndex, zIndex] = find_Lprime(x, z, xIndex, zIndex, n, N, epsilon);   
end
lambda = 0;
for i = 1:m-1
    if Lprime(i) ~= 0
        lambda = lambda + log2(Lprime(i)/L(i))/(N*deltaT);
    end 
end 
lambda;
end 