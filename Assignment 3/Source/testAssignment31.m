function testAssignment31()

% Defining folders for input and output images:
baseInputPath = '../Resources/';

filenames = [ 
    {'butterfly.jpg'} ;
    %{'circles.bmp'} ;
];

sigma = 3.0;
k = 1.25;
levels = 10;
threshold = 0.9;

% For each row of the filenames vector:
rowCount = size(filenames, 1);
for i = 1 : rowCount

    filename = char(filenames(i, 1));
    
    % Read the image:
    image = imread(strcat(baseInputPath, filename));
    
    % Use the k-means algortithm on the image:
    blobDetection(image, sigma, k, levels, threshold);
    
    % Advance only when keyboard key is pressed:
    while(waitforbuttonpress ~= 1)
    end
    
    % Close window:
    close all;
    
    % Scale image by half;
    halfSizeImage = imresize(image, 0.5);
    
    % Use the k-means algortithm on the half-sized image:
    blobDetection(halfSizeImage, sigma, k, levels, threshold);
    
end

end