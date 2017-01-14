function alphaChannel = create_alpha_channel(image)

% Create a alpha channel matrix initialized to 0:
alphaChannel =  zeros(size(image, 1), size(image, 2));

% Set ones at the borders:
alphaChannel(1, :) = 1;
alphaChannel(:, 1) = 1;
alphaChannel(:, size(alphaChannel,2)) = 1;
alphaChannel(size(alphaChannel,1), :) = 1;

% Linearly interpolate values using bwdist (1s become 0s):
alphaChannel = bwdist(alphaChannel);

% Normalize image:
alphaChannel = alphaChannel ./ max(max(alphaChannel));

end