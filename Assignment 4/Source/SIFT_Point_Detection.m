function SIFT_Point_Detection

baseInputPath = '../Resources/';

image = im2single(rgb2gray(imread(strcat(baseInputPath,'campus2.jpg'))));

imshow(image);

F = vl_sift(image);
vl_plotframe(F);


end