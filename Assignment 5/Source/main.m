run('..\..\vlfeat-0.9.20\toolbox\vl_setup.m');

folder = '../Resources/train/';
clusterCount = 50;

vocabulary = BuildVocabulary(folder, clusterCount);
[training, group] = BuildKNN(folder, vocabulary);
confusionMatrix = ClassifyImages(folder, vocabulary, training, group);