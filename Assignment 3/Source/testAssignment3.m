function testAssignment3()

filenames = [ 
    %{'butterfly.jpg'} ;
    {'circles.bmp'} ;
];

baseOutputPath = '../Output/';

sigma = 2.0;
k = 1.25;
levels = 10;

outputFiles(sigma, k, levels, filenames, baseOutputPath);

end