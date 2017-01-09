function test_assignment_4()

% Load vlfeat:
run('..\..\vlfeat-0.9.20\toolbox\vl_setup.m');

% Defining folders for input and output images:
baseInputPath = '../Resources/';

% Defining filenames:
filenames = [ ...
    {'campus1.jpg'} ;
    {'campus2.jpg'} ;
];

% Defining parameters:
matchingThreshold = 1.5;
distanceThreshold = 30;
iterationCount = 1000;

% Load images and convert them to grayscale:
imagesCount = size(filenames, 1);
images = cell(imagesCount);
for i = 1 : imagesCount
    
    % Get filename:
    filename = char(filenames(i, 1));
    
    % Concatenate base input path and filename:
    path = strcat(baseInputPath, filename);
    
    % Read image, convert it to gray scale and finally convert it to single
    % precision:
    images{i} = im2single(rgb2gray(imread(path)));    
    
end

% Apply the stitching algorithm to the images:
stitching(images, matchingThreshold, distanceThreshold, iterationCount);

end