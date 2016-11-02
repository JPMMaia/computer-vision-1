function [outputImage] = blobDetection(image, sigma, k, levels, threshold)

originalSigma = sigma;
[height, width] = size(image);

% [height,width] - dimensions of image
% levels - number of levels in the scale space
scale_space = zeros(height,width,levels);

    % 1. Start with an initial scale ?0 and repeatedly increase the scale by a constant factor k
for currLevel = 1 : levels    
        % Build a scale-normalized Laplacian of Gaussian filter with current scale ?.
        filter = fspecial('log', 2*floor(3*sigma) + 1, sigma) .* sigma^2;
    
        %Convolve the image with the filter and save the absolute response of LoG for the current level of scale space.
        convulution = imfilter (image,filter,'same','replicate');
        
        scale_space(:, :, currLevel) = convulution;
        
        % Update sigma at the end of the loop
        sigma = sigma * k;
end

absolute_scale_space = abs(scale_space);

max_space = zeros(height,width,levels);

filterMatrix = [1,1,1;1,0,1;1,1,1];

for currLevel = 1 : levels
% TODO: implement 3d comparison
    
    max_space(:,:,currLevel) = ordfilt2(absolute_scale_space(:,:,currLevel),8,filterMatrix);
    
end

circles = zeros(height,width);

for currLevel = 1 : levels
    for y = 1 : height
        for x = 1 : width
           if ( absolute_scale_space(y,x,currLevel) > threshold && absolute_scale_space(y,x,currLevel) > max_space(y,x,currLevel))
                circles(y,x) = originalSigma * k ^ (currLevel - 1);
           end
        end
    end
end

[cy,cx,radii] = find(circles);
radii = radii .* sqrt(2);

show_all_circles(image,cx,cy,radii);
outputImage = zeros(1);

end