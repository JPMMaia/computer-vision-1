function distortionMeasure = calculateDistortionMeasure(dataset, centroids, centroidAssignments)

    distortionMeasure = 0;

    k = size(centroids, 1);
    for centroidIndex = 1:k
       
        matches = centroidAssignments == centroidIndex;
        pointMatches = matches .* dataset;
        distanceVectors = pointMatches - centroids(centroidIndex);
        distances = sum(distanceVectors.^2, 2);
        
        distortionMeasure = distortionMeasure + sum(distances, 1);
        
    end

end