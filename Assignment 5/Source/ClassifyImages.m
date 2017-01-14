function confusionMatrix = ClassifyImages(folder, vocabulary, training, group)

% Get all subfolders:
subfolders = dir(folder);
subfoldersCount = size(subfolders, 1);

% For each subfolder:
histograms = zeros(800, 50);
expectedClasses = zeros(800, 1);
imageIndex = 1;
for i = 3 : subfoldersCount
   
    subfolder = subfolders(i);
    
    % Build the full path string to subfolder:
    subfolderPath = strcat(subfolder.folder, strcat('\', strcat(subfolder.name, '\')));
    
    % Enter inside the the subfolder:
    subfolderFiles = dir(subfolderPath);
    subfolderFilesCount = size(subfolderFiles, 1);
    
    % Set the class label equals to the directory index:
    classLabel = i - 2;
    
    % For each image inside the subfolder:
    for j = 3 : subfolderFilesCount
       
        file = subfolderFiles(j);
        filePath = strcat(subfolderPath, file.name);
        
        % Read a grayscale image and convert it to single precision:
        image = im2single(imread(filePath));
        
        % Extract features. In this step the SIFT features should be more
        % densely sampled than before, thus the step size should be 1 or 2.
        [~, imageDescriptors] = vl_dsift(image, 'Step', 1, 'Fast');
        
        % Find the nearest neighbor (visual word) for each image feature
        % descriptor point:
        matches = knnsearch(vocabulary', single(imageDescriptors)');
        
        % Compute the normalized histogram of visual words. That is all
        % SIFT features of an image are assigned to visual words and the
        % number of occurrences of every word is counted. The vector
        % (histogram) is normalized to unit length to account for changing
        % image resolutions.
        histogram = histcounts(matches, 1:51, 'Normalization', 'probability');
        
        % Cache result:
        histograms(imageIndex, :) = histogram;
        expectedClasses(imageIndex, 1) = classLabel;
        
        imageIndex = imageIndex + 1;

    end
end

% The last step is to classify all the images of the test set to
% investigate the classification power of the bag of visual words model for
% our classification task.
clusterCount = size(vocabulary, 2);
actualClasses = knnclassify(histograms, training, group, clusterCount);

% confusionMatrix is a matrix whose elements at position (i; j) indicate
% how often an image with class label i is classified to the class with
% label j.
classCount = 8;
confusionMatrix = zeros(classCount, classCount);
for imageIndex = 1 : size(actualClasses, 1)

    expectedClass = expectedClasses(imageIndex, 1);
    actualClass = actualClasses(imageIndex, 1);
    
    confusionMatrix(expectedClass, actualClass) = confusionMatrix(expectedClass, actualClass) + 1;
    
end

end