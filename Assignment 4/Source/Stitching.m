function Stitching () 

baseInputPath = '../Resources/';

image = im2single(rgb2gray(imread(strcat(baseInputPath,'campus1.jpg'))));

imshow(image);

F = vl_sift(image);
vl_plotframe(F);


end