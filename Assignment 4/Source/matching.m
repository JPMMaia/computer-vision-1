function finalHomography = matching (images, matchingThreshold, distanceThreshold, iterationCount)

image1 = images{1};
image2 = images{2};

% Apply sift to each image:
[points1, descriptors1] = vl_sift(image1);
[points2, descriptors2] = vl_sift(image2);

% Match the descriptors:
[matches, scores] = vl_ubcmatch(descriptors1, descriptors2, matchingThreshold);

% Find the correspence between matched points in the two images:
matchedPoints1 = points1(:, matches(1, :));
matchedPoints2 = points2(:, matches(2, :));

% Plot matches:
match_plot(image1, image2, matchedPoints1(1:2, :)', matchedPoints2(1:2, :)');

% Apply the RANSAC scheme to estimate the homography between the first and
% the second image:
[finalHomography, inliersMatchedPoints1, inliersMatchedPoints2] = ransac(matchedPoints1(1:2, :)', matchedPoints2(1:2, :)', distanceThreshold, iterationCount);

% Plot matches of inliers:
match_plot(image1, image2, inliersMatchedPoints1, inliersMatchedPoints2);

% Plot the absolute differences between the two images:
transformedImage1 = imtransform(image1, finalHomography, 'XData', [1 size(image2, 2)], 'YData', [1 size(image2, 1)], 'XYScale', [1.0, 1.0]);
differences = imfuse(image2, transformedImage1, 'diff');
imshow(differences);

end

