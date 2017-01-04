function [h] = getImageFeatures(wordMap,dictionarySize)

% Input: 
% wordMap: an H × W image containing the IDs of the visual words
% dictionarySize: the number of visual words in the dictionary.
% Output: 
% h: a dictionarySize × 1 histogram that is L1 normalized


% Histogram the index of the visual words according to the dictionarySize
h = hist(wordMap, 1:dictionarySize);

% Calculate the 1-norm of h
h = h / sum(h);


end