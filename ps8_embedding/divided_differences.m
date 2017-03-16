function divided_differences(dataPath, r)
%dataPath file of theta and time values t
%n is number of iterations
%r is the (down)sample rate -- skip every r lines 
%returns divided differences table DDT (n x 3), format [t theta omega] per row    
data = fopen(dataPath);
%get length of file
allText = textscan(data,'%s','delimiter','\n');
numberOfLines = length(allText{1});
fclose(data);

n = floor(numberOfLines/(r+1));

if n*(r+1) > numberOfLines
    error('n iterations at downsampling rate r exceeds file limit');
end 

theta = zeros(1,n);
time = zeros(1,n);
omega = zeros(1,n);

data = fopen(dataPath);
i = 1;
totLines = 0;
while i < n && totLines < numberOfLines-1
    %downsample then collect data
    for j = 1:r
        fgetl(data);
        totLines = totLines + 1;
    end
      
    line = fgetl(data);
    splitData = strsplit(line);
    theta(i) = str2double(splitData{1});
    time(i) = str2double(splitData{2});
    i = i + 1;
    totLines = totLines + 1;
end 
line = fgetl(data);
splitData = strsplit(line);
finalTheta = str2double(splitData{1});
finalTime = str2double(splitData{2});
fclose(data);

%plot for state space of theta vs omega
figure;
hold on;
title(['State space of theta vs omega over every ' num2str(r+1) 'th point']);
xlabel('Theta mod 2PI');
ylabel('Omega');
for i = 1:n
    %use forward divided differences to get derivative (omega)
    if i < n
       omega(i) = (theta(i+1)-theta(i))/(time(i+1)-time(i));
    else
       omega(i) = (finalTheta-theta(i))/(finalTime-time(i));
    end
    %and plot state-space
    if mod(theta(i),2*pi) ~= 0 && omega(i) < 1.5 && omega(i) > -1.5
        plot(mod(theta(i), 2*pi), omega(i),'.', 'MarkerSize', 5);
    end
end 



end