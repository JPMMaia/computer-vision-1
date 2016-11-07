function testAssignment22()

filenames = [ 
    {'mm.jpg'} ;
    ];

baseOutputPath = '../Output/Ex2/A22_';

for k = 2:10
    outputFiles(k, 3, filenames, baseOutputPath);
    outputFiles(k, 5, filenames, baseOutputPath);
end

end