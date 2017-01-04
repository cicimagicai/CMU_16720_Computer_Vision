%Loading the dictionary, filters and training data
numCores=2;
imageDir = '../images'; %where all images are located
targetDir = '../Q5.3/wordmap';%where we will store visual word outputs 
load('traintest.mat');
load('trainOutput.mat');

% After testing, k =15 can output the best accuracy 
k=15;
% The layer number for the spatial pyramid
layerNum = 3;
dictionarySize = size(dictionary,1);
labelsSize = size(classnames,1);

% Initialize confusion matrix
confusion = zeros(labelsSize,labelsSize);

for i=1:length(testImagePaths)
    % Load every test image
    testImg = imread(fullfile(imageDir,testImagePaths{i}));
    
    % Compute the test_wordMap for each testImg
    test_wordMap = getVisualWords(testImg,filterBank,dictionary);
    
    % get histogram w/ spatial pyramid
    testHist = getImageFeaturesSPM(layerNum, test_wordMap, dictionarySize);
    
    % Calculate the predLabel by knnClassify
    predictedLabel = knnClassify(testHist,trainHistograms,trainImageLabels,k);
    
    % Update confusion matrix
    confusion(testImageLabels(i),predictedLabel) = confusion(testImageLabels(i),predictedLabel) + 1;
    
    % Print the testImageLabel and predictedLabel for each testImg
    fprintf('%s   true: %d   predict: %d\n',testImagePaths{i},testImageLabels(i),predictedLabel);
end

% Display the confusion matrix
disp(confusion);

% Compute and display the accuracy of classified images
accuracy = trace(confusion) / sum(confusion(:));
disp(accuracy);
