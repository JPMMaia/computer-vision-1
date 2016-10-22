function testAssignment2()

% TODO

simpleImage = imread('../Resources/future.jpg');

outputImage = assignment2(simpleImage, 4);

imwrite(outputImage, '../Output/future_result.jpg');

end