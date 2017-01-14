function test_assignment_4_stitched()

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
matchingThreshold = 3;
distanceThreshold = 15;
iterationCount = 10000;

% Load images and convert them to grayscale:
imagesCount = size(filenames, 1);
images = cell(imagesCount);
colorimages = cell(imagesCount);
for i = 1 : imagesCount
    
    % Get filename:
    filename = char(filenames(i, 1));
    
    % Concatenate base input path and filename:
    path = strcat(baseInputPath, filename);
    
    % Read image, convert it to gray scale and finally convert it to single
    % precision:
    images{i} = im2single(rgb2gray(imread(path)));
    colorimages{i} = imread(path);
    
end

images12 = { images{1},images{2} };
images23 = { images{2},images{3} };
images43 = {images{4},images{3}};
images54 = {images{5},images{4}};

% Apply the matching algorithm to the images:
transform12 = matching(images12, matchingThreshold, distanceThreshold, iterationCount);
transform23 = matching(images23, matchingThreshold, distanceThreshold, iterationCount);
transform43 = matching(images43, matchingThreshold, distanceThreshold, iterationCount);
transform54 = matching(images54, matchingThreshold, distanceThreshold, iterationCount);

transform13 = maketform ( 'projective', transform23.tdata.T * transform12.tdata.T );
transform53 = maketform ( 'projective', transform43.tdata.T * transform54.tdata.T );

image1_y = [0,0,size(images{1},1),size(images{1},1)];
image1_x = [0,size(images{1},2),size(images{1},2),0];
[t1_x,t1_y] = tformfwd(transform13,image1_x,image1_y);

image2_y = [0,0,size(images{2},1),size(images{2},1)];
image2_x = [0,size(images{2},2),size(images{2},2),0];
[t2_x,t2_y] = tformfwd(transform23,image2_x,image2_y);

image4_y = [0,0,size(images{4},1),size(images{4},1)];
image4_x = [0,size(images{4},2),size(images{4},2),0];
[t4_x,t4_y] = tformfwd(transform43,image4_x,image4_y);

image5_y = [0,0,size(images{5},1),size(images{5},1)];
image5_x = [0,size(images{5},2),size(images{5},2),0];
[t5_x,t5_y] = tformfwd(transform53,image5_x,image5_y);

x_values = [t2_x,t4_x,t1_x,t5_x];
y_values = [t2_y,t4_y,t1_y,t5_y];

min_x = min(x_values);
min_y = min(y_values);

max_x = max(x_values);
max_y = max(y_values);

% Transform images and the alpha channels
nTform = maketform('projective',eye(3));

transformed1 = imtransform(colorimages{1},transform13,'XData',[min_x,max_x],'YData',[min_y,max_y]);
transformed2 = imtransform(colorimages{2},transform23,'XData',[min_x,max_x],'YData',[min_y,max_y]);
transformed3 = imtransform(colorimages{3},nTform,'XData',[min_x,max_x],'YData',[min_y,max_y]);
transformed4 = imtransform(colorimages{4},transform43,'XData',[min_x,max_x],'YData',[min_y,max_y]);
transformed5 = imtransform(colorimages{5},transform53,'XData',[min_x,max_x],'YData',[min_y,max_y]);

imshow(imfuse(imfuse(imfuse(imfuse(transformed2,transformed3),transformed4),transformed1),transformed5));

final = transformed1 +transformed5+transformed4+transformed3+transformed2;

imshow(final);
end



