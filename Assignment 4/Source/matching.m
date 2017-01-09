function matching (images, matchingThreshold, distanceThreshold, iterationCount)

image1 = images{1};
image2 = images{2};

% Apply sift to each image:
[points1, descriptors1] = vl_sift(image1);
[points2, descriptors2] = vl_sift(image2);

% Match the descriptors:
[matches, scores] = vl_ubcmatch(descriptors1, descriptors2, matchingThreshold);

inliersCount = zeros(1,iterationCount);
randomMatchesList = zeros(2,4,iterationCount);

% Number of matches:
matchCount = size(matches, 2);

for n = 1 : iterationCount
    
    try
        
        % Randomly choose 4 matches:
        randomMatches = matches(:, randsample(matchCount, 4));
        randomMatchesList(:,:,n) = randomMatches;
        
        rand_points_1 = points1(1:2,randomMatches(1,:));
        rand_points_2 = points2(1:2,randomMatches(2,:));
        t = cp2tform(rand_points_2', rand_points_1', 'projective');
        
        matched_points_1 = points1((1:2),matches(1,:));
        matched_points_2 = points2((1:2),matches(2,:));
        [trans_x,trans_y] = tformfwd(t,matched_points_1(1,:),matched_points_1(2,:));
        
        %Calculate distance between the original_points in image 2 and the
        %transformed ones from image 1 to image 2
        original_points = [matched_points_2(1,:)',matched_points_2(2,:)'];
        transformed_points = [trans_x',trans_y'];
        
        difference = original_points - transformed_points;
        distances = sqrt(sum(difference.^2,2))./2;
        
        %Count number of times dist > threshold (5)
        
        small_distances = distances < distanceThreshold;
        
        %Save result to inliers and inliers_list
        
        inliersCount(n) = nnz(small_distances);
        
        %inliers_list(n,:) = small_distances;
        
    catch
    end
    
    
end

[~,maxIndex] = max(inliersCount);

randomMatches = randomMatchesList(:,:,maxIndex);
rand_points_1 = points1(1:2,randomMatches(1,:));
rand_points_2 = points2(1:2,randomMatches(2,:));



matched_points_1 = points1((1:2),matches(1,:));
matched_points_2 = points2((1:2),matches(2,:));

t = cp2tform(rand_points_2', rand_points_1', 'projective');

[trans_x,trans_y] = tformfwd(t,matched_points_1(1,:),matched_points_1(2,:));

%Calculate distance between the original_points in image 2 and the
%transformed ones from image 1 to image 2
original_points = [matched_points_2(1,:)',matched_points_2(2,:)'];
transformed_points = [trans_x',trans_y'];

difference = original_points - transformed_points;
distances = sqrt(sum(difference.^2,2))./2;

%Count number of times dist > threshold (5)

small_distances = distances < distanceThreshold;

inliers_best_transform = matches(:,small_distances);


all_inliers_1 = points1(1:2,inliers_best_transform(1,:));
all_inliers_2 = points2(1:2,inliers_best_transform(2,:));
try
    [height, width] = size(image1);
    
    best_transform = cp2tform(all_inliers_2', all_inliers_1', 'projective');
    B = imtransform(image2,best_transform, 'XData',[1 width], 'YData',[1 height]);
    
    C = imfuse(image1, B, 'diff');
    imshow(C);
catch 
    matching(images, matchingThreshold, distanceThreshold, iterationCount);
end

end

