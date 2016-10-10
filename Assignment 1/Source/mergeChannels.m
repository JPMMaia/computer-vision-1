function colorImage = mergeChannels(redChannel, greenChannel, blueChannel)

% Calculate width and height of the final matrix:
channelDimensions = size(redChannel);

% Create a 3D matrix with the same width and height as the channels, and a
% depth of 3 to store each channel:
colorImage = zeros(channelDimensions(1), channelDimensions(2), 3, 'uint8');

% Copy each channel to its corresponding depth:
colorImage(:, :, 1) = redChannel;
colorImage(:, :, 2) = greenChannel;
colorImage(:, :, 3) = blueChannel;

end