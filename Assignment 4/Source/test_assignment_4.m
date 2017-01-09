function test_assignment_4()

% Load vlfeat:
run('vlfeat-0.9.20\toolbox\vl_setup.m');

% Defining folders for input and output images:
baseInputPath = '../Resources/';

% Defining filenames:
filenames = [ ...
    {'campus1.jpg'} ;
    {'campus2.jpg'} ;
    {'campus3.jpg'} ;
];

% Defining parameters:
matchingThreshold = 1.5;
distanceThreshold = 10;
iterationCount = 4000;

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

images12 = { images{2},images{1} };
images32 = { images{2},images{3} };


% Apply the matching algorithm to the images:
transform12 = matching(images12, matchingThreshold, distanceThreshold, iterationCount);
transform32 = matching(images32, matchingThreshold, distanceThreshold, iterationCount);

image1_y = [0,0,size(images{1},1),size(images{1},1)];
image1_x = [0,size(images{1},2),size(images{1},2),0];
[t1_x,t1_y] = tformfwd(transform12,image1_x,image1_y);

image3_y = [0,0,size(images{3},1),size(images{3},1)];
image3_x = [0,size(images{3},2),size(images{3},2),0];
[t3_x,t3_y] = tformfwd(transform32,image3_x,image3_y);

x_values = [t1_x,t3_x];
y_values = [t1_y,t3_y];

min_x = - size(images{2},2) * 1.5;
min_y = min(y_values);
max_x = size(images{2},2) * 1.5;
max_y = max(y_values);

nTform = maketform ('projective',eye(3));
transformed1 = imtransform(images{1},transform12,'XData',[min_x,max_x],'YData',[min_y,max_y]);
transformed3 = imtransform(images{3},transform32,'XData',[min_x,max_x],'YData',[min_y,max_y]);
transformed2 = imtransform(images{2},nTform,'XData',[min_x,max_x],'YData',[min_y,max_y]);

tmp = imfuse(transformed1, transformed2);
final = imfuse(transformed3,tmp);
imshow(final);
end





