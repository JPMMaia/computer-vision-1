function [finalHomography, inliersMatchedPoints1, inliersMatchedPoints2] = ransac(matchedPoints1, matchedPoints2, distanceThreshold, iterationCount)

% Get the number of matches:
matchCount = size(matchedPoints1, 1);

highestInliersCount = 0;
for i = 1 : iterationCount
   
    % Randomly choose four matches:
    randomIndices = randsample(matchCount, 4); 
    randomMatchedPoints1 = matchedPoints1(randomIndices, :);
    randomMatchedPoints2 = matchedPoints2(randomIndices, :);
    
    % Estimate the homography, which would transform points from the first
    % image to the second image:
    try
        homography = cp2tform(randomMatchedPoints1, randomMatchedPoints2, 'projective');
    catch
        i = i - 1;
        continue;
    end
    
    % Select all the other points:
    allOtherIndices = setdiff(1 : matchCount, randomIndices);
    allOtherMatchedPoints1 = matchedPoints1(allOtherIndices, :);
    allOtherMatchedPoints2 = matchedPoints2(allOtherIndices, :);
    
    % Transform all other points of the first image, using the estimated homography:
    [transformedMatchedPoints1X, transformedMatchedPoints1Y] = tformfwd(homography, allOtherMatchedPoints1(:, 1), allOtherMatchedPoints1(:, 2));
    transformedMatchedPoints1 = [transformedMatchedPoints1X, transformedMatchedPoints1Y];
    
    % Compute the Euclidean distance between the transformed points of the
    % first image and the corresponding points of the second image:
    distances = sqrt(sum( (transformedMatchedPoints1 - allOtherMatchedPoints2).^2,2));
    
    % Count the number of inliers:
    inliers = distances < distanceThreshold;
    inliersCount = sum(inliers);
    
    if(inliersCount > highestInliersCount)
       
        highestInliersCount = inliersCount; 
        inliersMatchedPoints1 = allOtherMatchedPoints1(inliers, :);
        inliersMatchedPoints2 = allOtherMatchedPoints2(inliers, :);
        
    end
    
end

% Reestimate the homography with all inliers to obtain a more accurate
% result:
finalHomography = cp2tform(inliersMatchedPoints1, inliersMatchedPoints2, 'projective');

end