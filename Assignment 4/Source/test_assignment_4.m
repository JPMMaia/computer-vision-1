function test_assignment_4()

% Load vlfeat:
run('..\..\vlfeat-0.9.20\toolbox\vl_setup.m');

% Defining folders for input and output images:
baseInputPath = '../Resources/';

% Defining filenames:
filenames = [ ...
    {'campus1.jpg'} ;
    {'campus2.jpg'} ;
    {'campus3.jpg'} ;
    {'campus4.jpg'} ;
    {'campus5.jpg'} ;
    ];

% Defining parameters:
matchingThreshold = 1.5;
distanceThreshold = 5;
iterationCount = 1000;

% Load images and convert them to grayscale:
imagesCount = size(filenames, 1);
grayImages = cell(imagesCount, 1);
coloredImages = cell(imagesCount, 1);
for i = 1 : imagesCount
    
    % Get filename:
    filename = char(filenames(i, 1));
    
    % Concatenate base input path and filename:
    path = strcat(baseInputPath, filename);
    
    % Read colored image:
    coloredImages{i} = im2single(imread(path));
    
    % Convert it to gray scale and finally convert it to single
    % precision:
    grayImages{i} = im2single(rgb2gray(coloredImages{i}));
    
end

homographiesCount = imagesCount - 1;
homographies = cell(homographiesCount, 1);
for i = 1 : homographiesCount
    
    % Determine the homography of a pair of images and cache the result in
    % an cell array:
    homographies{i} = matching(grayImages{i}, grayImages{i + 1}, matchingThreshold, distanceThreshold, iterationCount);
    
end

% Compute stitching of images:
stitchedImage = stitching(coloredImages, homographies, false);
imshow(stitchedImage);

end
