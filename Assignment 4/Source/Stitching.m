function Stitching ()

run('vlfeat-0.9.20\toolbox\vl_setup.m');

matchingThreshold = 1.5; % 1.5 is the default threshold
baseInputPath = '../Resources/';
nIter = 2000;
dist_threshold = 3;

image1 = im2single(rgb2gray(imread(strcat(baseInputPath,'campus4.jpg'))));
image2 = im2single(rgb2gray(imread(strcat(baseInputPath,'campus5.jpg'))));

[Points1,Descriptors1] = vl_sift(image1);
[Points2,Descriptors2] = vl_sift(image2);

[matches,scores] = vl_ubcmatch(Descriptors1,Descriptors2,matchingThreshold);

inliersCount = zeros(1,nIter);
rand_matches_list = zeros(2,4,nIter);

for n=1:nIter
    try
        rand_matches = matches(:,randsample(size(matches,2),4));
        rand_matches_list(:,:,n) = rand_matches;
        
        rand_points_1 = Points1(1:2,rand_matches(1,:));
        rand_points_2 = Points2(1:2,rand_matches(2,:));
        
        
        matched_points_1 = Points1((1:2),matches(1,:));
        matched_points_2 = Points2((1:2),matches(2,:));
        
        t = cp2tform(rand_points_2', rand_points_1', 'projective');
        
        
        [trans_x,trans_y] = tformfwd(t,matched_points_1(1,:),matched_points_1(2,:));
        
        %Calculate distance between the original_points in image 2 and the
        %transformed ones from image 1 to image 2
        original_points = [matched_points_2(1,:)',matched_points_2(2,:)'];
        transformed_points = [trans_x',trans_y'];
        
        difference = original_points - transformed_points;
        distances = sqrt(sum(difference.^2,2))./2;
        
        %Count number of times dist > threshold (5)
        
        small_distances = distances < dist_threshold;
        
        %Save result to inliers and inliers_list
        
        inliersCount(n) = nnz(small_distances);
        
        %inliers_list(n,:) = small_distances;
        
    catch
    end
    
    
end

[~,maxIndex] = max(inliersCount);

rand_matches = rand_matches_list(:,:,maxIndex);
rand_points_1 = Points1(1:2,rand_matches(1,:));
rand_points_2 = Points2(1:2,rand_matches(2,:));



matched_points_1 = Points1((1:2),matches(1,:));
matched_points_2 = Points2((1:2),matches(2,:));

t = cp2tform(rand_points_2', rand_points_1', 'projective');

[trans_x,trans_y] = tformfwd(t,matched_points_1(1,:),matched_points_1(2,:));

%Calculate distance between the original_points in image 2 and the
%transformed ones from image 1 to image 2
original_points = [matched_points_2(1,:)',matched_points_2(2,:)'];
transformed_points = [trans_x',trans_y'];

difference = original_points - transformed_points;
distances = sqrt(sum(difference.^2,2))./2;

%Count number of times dist > threshold (5)

small_distances = distances < dist_threshold;

inliers_best_transform = matches(:,small_distances);


all_inliers_1 = Points1(1:2,inliers_best_transform(1,:));
all_inliers_2 = Points2(1:2,inliers_best_transform(2,:));

try
    info = imfinfo(strcat(baseInputPath,'campus4.jpg'));
    
    best_transform = cp2tform(all_inliers_2', all_inliers_1', 'projective');
    B = imtransform(image2,best_transform, 'XData',[1 info.Width], 'YData',[1 info.Height]);
    
    C = imfuse(image1,B,'diff');
    imshow(C);
catch
    Stitching();
end

end

function estimateHomography ()

end