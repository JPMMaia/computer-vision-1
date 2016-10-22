function testAssignment2()

% Defining folders for input and output images:
baseInputPath = '../Resources/';
baseOutputPath = '../Output/';

% Defining filenames of the input and output images
filenames = [ 
    {'simple.png'} ;
    {'future.jpg'} ;
    {'mm.jpg'} ;
    ];

% Create output folder if it doesn't exist:
if ~exist(baseOutputPath, 'dir')
    mkdir(baseOutputPath);
end

% For each row of the filenames vector:
rowCount = size(filenames, 1);
for i = 1 : rowCount

    filename = char(filenames(i, 1));
    
    % Read the image:
    image = imread(strcat(baseInputPath, filename));
    
    % Use the k-means algortithm on the image:
    outputImage = assignment2(image, 3, 5, true);
    
    % Write the k-means colored image:
    imwrite(outputImage, strcat(baseOutputPath, filename));

end

end






