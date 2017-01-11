function [training, group] = BuildKNN(folder, vocabulary)

% Get all subfolders:
subfolders = dir(folder);
subfoldersCount = size(subfolders, 1);

% For each subfolder:
training = zeros(800, 50);
group = zeros(800, 1);
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
        
        % Cache results:
        training(imageIndex, :) = histogram;
        group(imageIndex, 1) = classLabel;
        
        imageIndex = imageIndex + 1;

    end
end

end