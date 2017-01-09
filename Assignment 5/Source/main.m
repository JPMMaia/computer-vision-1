vocabulary = BuildVocabulary(folder, clusterCount);
[training, group] = BuildKNN(folder, vocabulary);
confusionMatrix = ClassifyImages(folder, vocabulary, training, group);