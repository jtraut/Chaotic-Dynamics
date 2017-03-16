function plot_data(dataPath, D)
%D is the iteration param used, default is 20
%takes the data returned from TISEAN mutual and plots time delay vs mutual
%info
dataFile = fopen(dataPath);
%fgetl(dataFile); %dump the first line, it is not a tuple
%dataLine = fgetl(dataFile);
%splitData = strsplit(dataLine);
%BoxOcc = str2double(splitData{2}); %the shannon entropy (normalized to number of occupied boxes)

%set up plot
figure;
hold on;
title('Plot of dimensions M vs percentage of false nearest neighbors (FNN)');
xlabel('M');
ylabel('% FNN');
found = 0;

for i = 1:D
    size = 5;
    dataLine = fgetl(dataFile);
    splitData = strsplit(dataLine);
    m = str2double(splitData{1});
    fraction = str2double(splitData{2});
    if fraction < .1 && ~found
        size = 11;
        found = 1;
        i
    end

    plot(m, fraction, '*', 'MarkerSize', size);   
end

end