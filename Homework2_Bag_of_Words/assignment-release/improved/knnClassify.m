function [predictedLabel] = knnClassify(wordHist,trainHistograms,trainingLabels,k)

% Calculate the similarity between wordHist and trainHistograms
histInter = distanceToSet(wordHist, trainHistograms);

%% Sort the histInter in descending order according to the similarity
%[histInter_sort, index] = sort(histInter, 'descend');

%% Sort the histInter in ascending order according to the L Norm Elucidean Distance
[histInter_sort, index] = sort(histInter, 'ascend');

%% Get the top k trainingLabels as the most similar labels
knnLabels = trainingLabels(index(1:k));

% Calculate the highest frequency label in knnLabels
predictedLabel = mode(knnLabels);


end
