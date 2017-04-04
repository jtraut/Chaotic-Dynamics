function box_counting(e0, m, dataPath)
%Implementation of box counting algorithm for computing capacity dimension
%Input: e0 - the minimum value of epsilon, m - how many iterations of growing e0, dataPath - contains the x y z trajectory of a system
%Output: Dcap: capacity dimension 

data = fopen(dataPath);
%get length of file
allText = textscan(data,'%s','delimiter','\n');
numberOfLines = length(allText{1});
fclose(data);

n = numberOfLines;

data = fopen(dataPath);
x = cell(n,3);
%set up min and max values to determine the data state space 
xMin = 1000; xMax = -1000;
yMin = 1000; yMax = -1000;
zMin = 1000; zMax = -1000;
for i = 1:n
    %store the trajectory data to be accessible 
    line = fgetl(data);
    splitData = strsplit(line);
    %the first entry of data is the time, so skip that
    X = str2double(splitData(2));
    Y = str2double(splitData(3));
    Z = str2double(splitData(4));
    if X < xMin
        xMin = X;
    elseif X > xMax
        xMax = X;
    end
    if Y < yMin
        yMin = Y;
    elseif Y > yMax
        yMax = Y;
    end
    if Z < zMin
        zMin = Z;
    elseif Z > zMax
        zMax = Z;        
    end
    x{i} = [X Y Z];
end 
fclose(data); 

%now have state space, define the hyper cubes
boxes = {}; 
i = 1; j = 1; k = 1; half = e0/2;
X = xMin; Y = yMin; Z = zMin;
while X <= xMax || Y <= yMax || Z <= zMax
    %store the origins of the boxes 
    boxes{i,j,k} = [X Y Z];  
    
    if X <= xMax %grow in x direction when can
        X = X + e0;
        i = i + 1;
    elseif Y <= yMax %else move back 1 y row and grow in x direction again
        Y = Y + e0;
        X = xMin;
        j = j + 1;
        xBoxes = i;
        i = 1;
    elseif Z <= zMax %else move up 1 z layer and grow from x y min corner again       
        Z = Z + e0;
        X = xMin;
        Y = yMin;
        k = k + 1;
        i = 1;
        yBoxes = j;
        j = 1;
    end
end 
zBoxes = k;

boxBool = zeros(xBoxes, yBoxes, zBoxes); %set value to 1 if that box has point in it
N = zeros(1,m);
%loop through all points find what box located in and set corresponding boxBool to 1
for i = 1:n
    xPt = x{i}(1);
    yPt = x{i}(2);
    zPt = x{i}(3);
    %refine the search towards the location of box 
    if xPt >= xMax/2
        xStart = round(xBoxes/2)-round(xBoxes/10); %scale the offset according to dimension length
    else 
        xStart = 1;
    end  
    if yPt >= yMax/2
        yStart = round(yBoxes/2)-round(yBoxes/10); 
    else 
        yStart = 1;
    end
    if zPt >= zMax/2
        zStart = round(zBoxes/2)-round(zBoxes/10); 
    else
        zStart = 1; 
    end

    found = 0; 
    %locate box 1 dimension at a time
    for xi = xStart:xBoxes
       X = boxes{xi,yStart,zStart}(1);
       if xPt >= X-half && xPt <= X+half
          xIndex = xi;
          break;
       end
    end
    for yi = yStart:yBoxes
      Y = boxes{xIndex,yi,zStart}(2);
        if yPt >= Y-half && yPt <= Y+half
            yIndex = yi;
            break;
        end    
    end
    for zi = zStart:zBoxes
        Z = boxes{xIndex,yIndex,zi}(3);
        if zPt >= Z-half && zPt <= Z+half
            if ~boxBool(xIndex,yIndex,zi)
                boxBool(xIndex,yIndex,zi) = 1;
                N(1) = N(1) + 1; %N(e0) is number of matrix entries that are true (1)
            end
            found = 1;    
            break;
        end
    end
    if ~found
        x{i} %get a clue as to whats going on if a point is not being located within a hyper cube (but shouldn't happen anymore)
    end
end

%N(2^m * e0) calculated from entries of the boolean array by partitioning
%the e0 grid into larger cubes of side e0*2^m (for m = 2 ... M)
for i = 2:m
    j = 0;
    xi = 1; yi = 1; zi = 1;
    while xi < xBoxes && yi < yBoxes && zi < zBoxes
        for j = 1:2^i-1
            if (xi+j > xBoxes || yi+j > yBoxes || zi+j > zBoxes)
                break;
            end
            if (boxBool(xi,yi,zi) || boxBool(xi+j,yi,zi) || boxBool(xi,yi+j,zi) || boxBool(xi,yi,zi+j) || boxBool(xi+j,yi+j,zi) || boxBool(xi+j,yi,zi+j) || boxBool(xi, yi+j, zi+j) || boxBool(xi+j,yi+j,zi+j))
                %N(2^m * e0) is number of these larger cubes that contain at least one e0
                %cube with a true boolean array entry     
                N(i) = N(i) + 1;
                break;
            end
        end
        
        if xi+2^i < xBoxes
            xi = xi+2^i;
        elseif yi+2^i < yBoxes
            yi = yi+2^i;
            xi = 1;
        elseif zi+2^i < zBoxes
            zi = zi+2^i;
            xi = 1;
            yi = 1;
        else %end the loop
            xi = xBoxes;
            yi = yBoxes;
            zi = zBoxes;
        end
    end
end

%set up plot
figure;
hold on;
title(['Plot of log(1/e) vs log(N(e)) with e0=' num2str(e0) ' and M=' num2str(m) ' (Dcap)']);
xlabel('log(1/e)');
ylabel('log(N(e))');

M = m;
for i = 1:M
    if i == 1
        m = 0;
    else 
        m = i;
    end 
    N(i)
    plot(log(1/(e0*(2^m))),log(N(i)),'.','MarkerSize',6)
end
end