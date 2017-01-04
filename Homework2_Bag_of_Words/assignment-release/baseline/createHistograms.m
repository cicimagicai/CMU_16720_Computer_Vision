function outputHistograms = createHistograms(dictionarySize,imagePaths,wordMapDir)
% Code to compute histograms of all images from the visual words
% Input:
% dictionarySize: the number of visual words in the dictionary
% imagePaths: a cell array containing paths of the images
% wordMapDir: directory name which contains all the wordmaps
% Output:
% outputHistograms: a wordHist_size × num_images matrix of histograms, which will
% store the histograms of training images.

L = 3;
K = dictionarySize;
wordHist_size = K * (4^(L+1) - 1) / 3;
num_images = length(imagePaths);

% Create the size for outputHistograms
outputHistograms = zeros(wordHist_size, num_images);

for i = 1:num_images
    % The path of each image
    imgPath = imagePaths{i};
    
    % Get the matPath of each image
    img_matPath = strrep(imgPath, 'jpg', 'mat');
    img_matPath = fullfile(wordMapDir, img_matPath);
    
    % Load the mat file of each image
    img_mat = load(img_matPath);
    
    % Calculate the histogram of each image
    img_hist = getImageFeaturesSPM(L, img_mat.wordMap, K);
    
    % Put the histograms together
    outputHistograms(:, i) = img_hist;
    
end

end
