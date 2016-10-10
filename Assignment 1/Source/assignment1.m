redChannel = imread('../Resources/00125v_R.jpg');
greenChannel = imread('../Resources/00125v_G.jpg');
blueChannel = imread('../Resources/00125v_B.jpg');

colorImage = mergeChannels(redChannel, greenChannel, blueChannel);

imwrite(colorImage, '../Output/00125v_RGB.jpg');
