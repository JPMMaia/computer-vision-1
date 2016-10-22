% Dataset is a matrix in which each row represents a pixel (r, g, b, x, y)
% Centroids is a matrix in which each row represents a centroid (r, g, b,
% x, y)
% k is the number of centroids
% This function should return a matrix where each row 
function centroids = computeCentroids(dataset, centroidAssignments, k)

    centroids = zeros(k, size(dataset, 2));

    for centroidIndex = 1:k
       
        matches = centroidAssignments == centroidIndex;
        numMatches = sum(matches);
        
        if numMatches > 0
            pointMatches = matches .* dataset;
            centroids(centroidIndex, :) = sum(pointMatches, 1) ./ numMatches;
        end
        
    end

end