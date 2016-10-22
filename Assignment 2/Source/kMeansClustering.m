function outputImage = kMeansClustering(image, k)

imageDimensions = size(image);
width = imageDimensions(1);
height = imageDimensions(2);
%dimensions = imageDimensions(3);
dimensions = 5;

% Normalize R, G, B: TODO normalize x, y
normalizedImage = image ./ 255;
dataset = zeros(width * height, dimensions);

% Create dataset matrix
rowIndex = 1;
for i = 1:height
    for j = 1:width
        
        dataset(rowIndex, 1) = normalizedImage(j, i, 1);
        dataset(rowIndex, 2) = normalizedImage(j, i, 2);
        dataset(rowIndex, 3) = normalizedImage(j, i, 3);
        %dataset(rowIndex, 4) = j / width;
        %dataset(rowIndex, 5) = i / height;
        rowIndex = rowIndex + 1;
        
    end
end

% Assign random values to the centroids
centroids = rand(k, dimensions);
% centroids = [
%   0.8, 0, 0, 0.3, 0.6; 
%   0, 0.8, 0, 0.6, 0.4;
%   0, 0, 0.8, 0.8, 0.4;
% ];

% for loop until there is no significant changes:
oldDistortionMeasure = Inf(1);

done = false;
while ~done
    
    centroidAssignments = findClosestCentroids(dataset, centroids);
    centroids = computeCentroids(dataset, centroidAssignments, k);
    
    newDistortionMeasure = calculateDistortionMeasure(dataset, centroids, centroidAssignments);
    if(oldDistortionMeasure / newDistortionMeasure < 1.000001)
        done = true;
    end
    oldDistortionMeasure = newDistortionMeasure;
    
end

%Output computed Image
outputImage = zeros(width,height,3);
pixelIndex = 1;
for i=1:height
    for j=1:width
        outputImage(j,i,:) = centroids(centroidAssignments(pixelIndex),1:3).*255;
        pixelIndex = pixelIndex +1;
    end
end

% DRAW CIRCLES
% yellow = uint8([0 0 0]);
% shapeInserter = vision.ShapeInserter('Shape','Circles','BorderColor','Custom',...
% 'CustomBorderColor',yellow);
% circles = zeros(k,3);
%     for i=1:k
%         circles(i,:)= int32([centroids(i,5).*height centroids(i,4).*width 20]); %  [x1 y1 radius1;x2 y2 radius2]
%           
% 
%     end
%     outputImage= shapeInserter(outputImage, circles);  
end