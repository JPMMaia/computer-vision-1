% Each row in dataset represents a point (r, g, b, x, y)
% Each row in centroids represents a centroid (r, g, b, x, y)
% Each row in ids is a number in the range [1, k], that assigns each point to a centroid
function centroidAssignments = findClosestCentroids(dataset, centroids)

    % Initializng centroidAssignments:
    centroidAssignments = zeros(size(dataset, 1), 1);
    
    k = size(centroids, 1);
    
    for pointIndex = 1:size(dataset, 1)
       
        minDistance = Inf(1);
        minDistanceIndex = -1;
        for centroidIndex = 1:k
        
            distanceVector = (dataset(pointIndex, :) - centroids(centroidIndex, :));
            distance = sqrt(sum(distanceVector.^2));
            if(distance < minDistance)
               
                minDistance = distance;
                minDistanceIndex = centroidIndex;
                
            end
            
        end
        
        centroidAssignments(pointIndex) = minDistanceIndex;
        
    end

end