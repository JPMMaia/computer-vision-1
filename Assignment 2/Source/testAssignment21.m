function testAssignment21()

filenames = [ 
    {'simple.png'} ;
    {'future.jpg'} ;
    {'mm.jpg'} ;
    ];

baseOutputPath = '../Output/Ex1/';

outputFiles(3, 3, filenames, baseOutputPath);
outputFiles(3, 5, filenames, baseOutputPath);

end