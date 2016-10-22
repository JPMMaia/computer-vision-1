function [centroidAssignments, centroids] = kMeansClustering(dataPoints, k)

% Assign random values to the centroids:
centroids = rand(k, size(dataPoints, 2));

% While there are significant changes on the distorion measure:
oldDistortionMeasure = Inf(1);
done = false;
while ~done
    
    % Assign all data points to their nearest cluster centroids:
    centroidAssignments = findClosestCentroids(dataPoints, centroids);
    
    % Compute the new cluster centroids as the mean of all data points
    % assigned to the respective cluster:
    centroids = computeCentroids(dataPoints, centroidAssignments, k);
    
    % Compute the distortion measure and check if there are significant
    % changes:
    newDistortionMeasure = calculateDistortionMeasure(dataPoints, centroids, centroidAssignments);
    if(abs(oldDistortionMeasure / newDistortionMeasure - 1.0) < 0.00001)
        done = true;
    end
    oldDistortionMeasure = newDistortionMeasure;
    
end
 
end