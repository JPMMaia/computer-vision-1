function testAssignment1()

% Defining folders for input and output images:
baseInputPath = '../Resources/';
baseOutputPath = '../Output/';

% Defining filenames of the input and output images. The first 3 filenames in
% a row are for the R, G and B channels and the 4th filename is the output
% colored image:
filenames = [ 
    {'00125v_R.jpg'} {'00125v_G.jpg'} {'00125v_B.jpg'} {'00125v_RGB.jpg'} ;
    {'00149v_R.jpg'} {'00149v_G.jpg'} {'00149v_B.jpg'} {'00149v_RGB.jpg'} ;
    {'00153v_R.jpg'} {'00153v_G.jpg'} {'00153v_B.jpg'} {'00153v_RGB.jpg'} ;
    {'00351v_R.jpg'} {'00351v_G.jpg'} {'00351v_B.jpg'} {'00351v_RGB.jpg'} ;
    {'00398v_R.jpg'} {'00398v_G.jpg'} {'00398v_B.jpg'} {'00398v_RGB.jpg'} ;
    {'01112v_R.jpg'} {'01112v_G.jpg'} {'01112v_B.jpg'} {'01112v_RGB.jpg'} ;
    ];

% Create output folder if it doesn't exist:
if ~exist(baseOutputPath, 'dir')
    mkdir(baseOutputPath);
end

% For each row of the filenames matrix:
rowCount = size(filenames, 1);
for i = 1 : rowCount

    % Read the channels:
    redChannel = imread(strcat(baseInputPath, char(filenames(i, 1))));
    greenChannel = imread(strcat(baseInputPath, char(filenames(i, 2))));
    blueChannel = imread(strcat(baseInputPath, char(filenames(i, 3))));

    % Align channels and merge them into one RGB image:
    coloredImage = assignment1(redChannel, greenChannel, blueChannel);
    
    % Write the colored image:
    imwrite(coloredImage, strcat(baseOutputPath, char(filenames(i, 4))));

end

end