function outputFiles(sigma, k, levels, filenames, baseOutputPath)

% Defining folders for input and output images:
baseInputPath = '../Resources/';

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
    outputImage = blobDetection(image, sigma, k, levels, 0);
    
    % Write the k-means colored image:
    %kStr = strcat('k', num2str(k));
    %dStr = strcat('d', num2str(d));
    %prefix = strcat(strcat(kStr, dStr), '_');
    %imwrite(outputImage, strcat(baseOutputPath, strcat(prefix, filename)));

end

end