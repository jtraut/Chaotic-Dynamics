function coord_embedding(dataPath, tau, m, j, k)
%tau is time interval
%m dimensions 
%indices j and k of pair of axes on which to plot results 
%produces corresponding trajectory in reconstruction space 

data = fopen(dataPath);
%get length of file
allText = textscan(data,'%s','delimiter','\n');
numberOfLines = length(allText{1});
fclose(data);
deltaT = 0.001;
ts = 0; delay = 0;
while ts  < tau
    %compute the downsample rate, delay 
    ts = ts + deltaT;
    delay = delay + 1; 
end
n = numberOfLines;
theta = zeros(1,n);
time = zeros(1,n);

data = fopen(dataPath);
for i = 1:n
    %store the data in appropriate vectors   
    line = fgetl(data);
    splitData = strsplit(line);
    theta(i) = str2double(splitData{1});
    time(i) = str2double(splitData{2});
end 
fclose(data);

mv = zeros(1,m); %m-vector
%produce list of m-vectors whose ith element is theta(t + i*tau)
i = 1;
reconSpace = cell([m,n-m*delay]);
while i < n-m*delay
    for l = 1:m
        if i+l*delay > n
            break;
        end
        mv(l) = theta(i+l*delay); %theta is stored at the time interval tau
    end
    reconSpace{i} = mv;

    i = i+1;
    
end
reconLength = i-1;
%plot for reconstructed state space of theta(t) vs theta(t+k*tau)
figure;
hold on;
title(['State space of theta(t) vs theta(t+' num2str(k-1) 'tau) for tau = ' num2str(tau)]);
ylabel(['theta(t+' num2str(k-1) 'tau) mod 2PI']);
xlabel('theta(t) mod 2PI');
for i = 1:reconLength
    plot(mod(reconSpace{i}(j), 2*pi), mod(reconSpace{i}(k), 2*pi),'.','MarkerSize',1);
end 

end 