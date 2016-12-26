function outputImage = assignment2(image, k, dataPointDimensions, drawCircles)

% Get the image dimensions:
imageDimensions = size(image);
width = imageDimensions(1);
height = imageDimensions(2);

% Create data points from the image matrix:
dataPoints = zeros(width * height, dataPointDimensions);
dataPointIndex = 1;
for i = 1:height
    for j = 1:width
        
        % Building a data point consiting of RGB values:
        dataPoints(dataPointIndex, 1) = image(j, i, 1);
        dataPoints(dataPointIndex, 2) = image(j, i, 2);
        dataPoints(dataPointIndex, 3) = image(j, i, 3);
        
        % If we are working on 5D data points, add the position of the
        % pixel on the image matrix:
        if(dataPointDimensions == 5)
            dataPoints(dataPointIndex, 4) = j / width;
            dataPoints(dataPointIndex, 5) = i / height;
        end
        
        % Next data point:
        dataPointIndex = dataPointIndex + 1;
        
    end
end

% Run the k-means algorithm on the data points:
[centroidAssignments, centroids] = kMeansClustering(dataPoints, k);

% Output computed image:
outputImage = zeros(width, height, 3);
dataPointIndex = 1;
for i = 1:height
    for j = 1:width
        outputImage(j, i, :) = centroids(centroidAssignments(dataPointIndex), 1:3);
        dataPointIndex = dataPointIndex + 1;
    end
end

% If draw circles flag is enabled:
% if drawCircles
%     
%     color = uint8([0 0 0]);
%     shapeInserter = vision.ShapeInserter('Shape', 'Circles', 'BorderColor', 'Custom', 'CustomBorderColor', color);
%     
%     circles = zeros(k,3);
%     for i=1:k
%         circles(i,:)= int32([centroids(i,5).*height, centroids(i,4).*width, 20]);
%     end
%  
%     % Draw the circles on the output image:
%     outputImage = shapeInserter(outputImage, circles);  
%     
% end

end