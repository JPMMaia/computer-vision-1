function colorImage = assignment1(redChannel, greenChannel, blueChannel)

% Allign both the 'greenChannel' and the 'blueChannel' with the
% 'redChannel', using a window of displacements of [-15, 15]:
displacementWindow = [-15, 15];
[redChannel, greenChannel] = allignChannels(redChannel, greenChannel, displacementWindow);
[redChannel, blueChannel] = allignChannels(redChannel, blueChannel, displacementWindow);

% Merge aligned channels into one RGB image:
colorImage = mergeChannels(redChannel, greenChannel, blueChannel);

end