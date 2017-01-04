function [wordMap]=getVisualWords(I,filterBank,dictionary)

% Input:
% I: an H × W image
% filterBank: 33 × 1 cell filters
% dictionary: an K × 99 matrix that contains the visual words
% Output:
% wordMap: an H × W image containing the IDs of the visual words


% Get the image Dimension
imgDim = size(I);

% Calculate the responses of each image
% imgResponses is a H*W × 99 matrix
imgResponses = extractFilterResponses(I, filterBank);

% Compute the distances between imgResponses of the filterBank at each pixel 
% and dictionary of visual words.
% dist is a H*W × K matrix
dist = pdist2(imgResponses, dictionary);

% Compute the index of the closest distance in every row
% index is a H*W × 1 vector
[minDist,index] = min(dist,[],2);

% Reshape the H × W wordMap matrix
% Each pixel in wordMap is assigned the index of the closest visual world
% of the imgResponses at the pixel in Image.
wordMap = reshape(index, imgDim(1:2));

    
end

