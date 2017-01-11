run('..\..\vlfeat-0.9.20\toolbox\vl_setup.m');

trainSetFolder = '../Resources/train/';
testSetFolder = '../Resources/test/';
clusterCount = 50;

vocabulary = BuildVocabulary(trainSetFolder, clusterCount);
[training, group] = BuildKNN(trainSetFolder, vocabulary);
confusionMatrix = ClassifyImages(testSetFolder, vocabulary, training, group);