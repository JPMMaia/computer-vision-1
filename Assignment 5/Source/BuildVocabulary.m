function vocabulary = BuildVocabulary(folder, clusterCount)

% Get all subfolders:
subfolders = dir(folder);
subfoldersCount = size(subfolders, 1);

% For each subfolder:
descriptors = [];
imageIndex = 1;
for i = 3 : subfoldersCount
   
    subfolder = subfolders(i);
    
    % Build the full path string to subfolder:
    subfolderPath = strcat(subfolder.folder, strcat('\', strcat(subfolder.name, '\')));
    
    % Enter inside the the subfolder:
    subfolderFiles = dir(subfolderPath);
    subfolderFilesCount = size(subfolderFiles, 1);
    
    % For each image inside the subfolder:
    for j = 3 : subfolderFilesCount
       
        file = subfolderFiles(j);
        filePath = strcat(subfolderPath, file.name);
        
        % Read a grayscale image and convert it to single precision:
        image = im2single(imread(filePath));
        
        % Extract features.
        % We do not necessarily need to extract a SIFT feature for every pixel for
        % vocabulary creation, e.g. around 100 features per image are enough to
        % "capture" the approximately correct distribution of SIFT features for the
        % given image data:
        [~, imageDescriptors] = vl_dsift(image, 'Step', 22, 'Fast');
% TODO normalize
        % Optionally select only a random subset of features per image for the
        % overall set (the function randsample might be helpful):
        
        % Add descriptors to global list:
        % TODO optimize by prealocating memory:
        descriptors = [ descriptors single(imageDescriptors) ];
        imageIndex = imageIndex + 1;
        
    end
    
end

% After all SIFT features have been collected, you should apply K-means
% clustering to find the visual words. Instead of the Matlab function or
% your own K-means function from Assignment 2, vl_kmeans can be used here
% for performance reasons.
[vocabulary, ~] = vl_kmeans(descriptors, clusterCount);

end