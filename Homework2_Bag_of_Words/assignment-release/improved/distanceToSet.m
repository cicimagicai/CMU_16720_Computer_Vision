function [histInter] = distanceToSet(wordHist, histograms)

% Input:
% wordHist: K*(4^(L+1)−1)/3 × 1 vector
% histograms: K*(4^(L+1)−1)/3 × T matrix
% Output:
% histInter: the histogram intersection similarity

%% Compute the intersection similarity between two histograms
% The bigger histInter is, the more similar between wordHist and histograms
%histInter = sum(bsxfun(@min,wordHist,histograms));

%% L1 Norm Eluclidean Distance
histInter = sum(abs(bsxfun(@minus, wordHist, histograms)));

%% L2 Norm Eluclidean Distance
%histInter = sqrt(sum((bsxfun(@minus, wordHist, histograms)).^2));

end
