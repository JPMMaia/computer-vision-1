function SIFT_Point_Detection

baseInputPath = '../Resources/';

image1 = im2single(rgb2gray(imread(strcat(baseInputPath,'campus2.jpg'))));
image2 = im2single(rgb2gray(imread(strcat(baseInputPath,'campus3.jpg'))));

imshow(image1);

[fa, da] = vl_sift(image1) ;
[fb, db] = vl_sift(image2) ;


[matches, scores] = vl_ubcmatch(da,db);

matches1 = fa(1:2,matches(1,1:60));
matches2 = fb(1:2,matches(2,1:60));
match_plot(image1,image2,matches1',matches2');

%vl_plotframe(F1);


end