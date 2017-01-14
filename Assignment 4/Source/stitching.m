function stichedImage = stitching(coloredImages, homographies, feathering)

imagesCount = length(coloredImages);
homographiesCount = imagesCount - 1;
referenceImageIndex = ceil(imagesCount / 2);

% Compute the homographies that map from images at the left of the
% reference image to the reference image:
for i = 1 : referenceImageIndex - 1
    
    compositeHomography = eye(3);

    for j = i : referenceImageIndex - 1
        compositeHomography = homographies{j}.tdata.T * compositeHomography;
    end
    
    homographies{i} =  maketform('projective', compositeHomography);

end

% Compute the homographies that map from images at the right of the
% reference image to the reference image:
for i = homographiesCount : -1 : referenceImageIndex
    
    compositeHomography = eye(3);

    for j = referenceImageIndex : i
        compositeHomography = compositeHomography * homographies{j}.tdata.Tinv;
    end
    
    homographies{i} =  maketform('projective', compositeHomography);

end

% Transform the corners of each image to the reference coordinate frame
% to determine its coordinates in the output image:
homographyImagesIndices = setdiff(1 : imagesCount, referenceImageIndex);
outputImageCoordinatesX = zeros(homographiesCount, 4);
outputImageCoordinatesY = zeros(homographiesCount, 4);
for i = 1 : homographiesCount
   
    % Get image dimensions:
    [imageHeight, imageWidth, ~] = size(coloredImages{homographyImagesIndices(i)});
    
    % Set the corners of the image:
    cornersX = [ 0, imageWidth, imageWidth, 0  ];
    cornersY = [ 0, 0, imageHeight, imageHeight ];
    
    % Transform the corners of the image to the reference coordinate frame
    % to determine its coordinates in the output image:
    [transformedCornersX, transformedCornersY] = tformfwd(homographies{i}, cornersX, cornersY);
    
    % Cache transformed corners:
    outputImageCoordinatesX(i, :) = transformedCornersX;
    outputImageCoordinatesY(i, :) = transformedCornersY;
    
end

% Calculate the minimun and maximun values of the transformed corners:
minX = min(min(outputImageCoordinatesX));
minY = min(min(outputImageCoordinatesY));
maxX = max(max(outputImageCoordinatesX));
maxY = max(max(outputImageCoordinatesY));

% Transform all images to the plane defined by the reference image:
homographies = [ homographies(1:referenceImageIndex-1) ; maketform('projective', eye(3)) ; homographies(referenceImageIndex:end) ];
homographiesCount = homographiesCount + 1;
finalImages = cell(homographiesCount, 1);
transformedAlphaImages = cell(homographiesCount, 1);
for i = 1 : imagesCount
   
    % Select image to transform and corresponding homography:
    imageToTransform = coloredImages{i};
    homography = homographies{i};
    
    % Tranform image:
    finalImages{i} = imtransform(imageToTransform, homography, 'XData', [minX, maxX], 'YData', [minY, maxY]);
    %imshow(transformedImages{i});
    
    % Create alpha image and transformed it:
    alphaImage = create_alpha_channel(imageToTransform);
    transformedAlphaImages{i} = imtransform(alphaImage, homography, 'XData', [minX, maxX], 'YData', [minY, maxY]);

end

stichedImage = zeros(size(finalImages{1}));
if feathering
    
    transformedAlphaImagesSum = zeros(size(transformedAlphaImages{1}));
    for i = 1 : imagesCount

        % Sum the contributions of each image by multiplying each color value
        % by a correspont alpha value:
        stichedImage = stichedImage + repmat(transformedAlphaImages{i}, 1, 1, 3) .* finalImages{i};

        % Sum the alpha values:
        transformedAlphaImagesSum = transformedAlphaImagesSum + transformedAlphaImages{i};

    end

    % For each pixel, divide by the sum of alphas at that pixel:
    stichedImage = stichedImage ./ transformedAlphaImagesSum;

else
    
    for i = 1 : imagesCount

        stichedImage(~stichedImage) = finalImages{i}(~stichedImage);

    end
    
end



end