function testAssignment31()

% Defining folders for input and output images:
baseInputPath = '../Resources/';

filenames = [ 
    {'butterfly.jpg'} ;
    %{ 'BlackImage.bmp' } ;
    %{ 'WhiteImage.png' } ;
    %{'circles.bmp'} ;
];

sigma = 2.0;
k = 1.25;
levels = 10;
threshold = 0.5;

% For each row of the filenames vector:
rowCount = size(filenames, 1);
for i = 1 : rowCount

    filename = char(filenames(i, 1));
    
    % Read the image and normalized it between 0 and 1:
    image = mean(imread(strcat(baseInputPath, filename)), 3);
    image = image - min(image(:)) ;
    image = image / max(image(:)) ;
    
    % Use the k-means algortithm on the image:
    blobDetection(image, sigma, k, levels, threshold);
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