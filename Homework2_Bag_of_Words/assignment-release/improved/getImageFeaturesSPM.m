function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)

% Input:
% layerNum: the number of layers in the spatial pyramid, i.e., L + 1
% wordMap: an H × W image containing the IDs of the visual words
% dictionarySize: the number of visual words in the dictionary
% Output:
% h: a dictionarySize × 1 histogram that is L1 normalized

% The number of current layer
L = layerNum;
% K visual words
K = dictionarySize;
% The histograms together after normalization by the total number of
% features in the image.
h = zeros(K * (4^(L+1)-1) / 3, 1);
% The index of in the histogram
index = 0;

for l = (L-1):-1:0
    % Get the height and width of 2^l × 2^l cell
    cell_H = floor(size(wordMap, 1) / (2^l));
    cell_W = floor(size(wordMap, 2) / (2^l));
    
    for i = 1:2^l
        for j = 1:2^l
            % Get the wordMap for the corresponding cell
            cell_hist= hist(wordMap((i-1)*cell_H+1 : i*cell_H,...
                                    (j-1)*cell_W+1 : j*cell_W), 1:K);
            % Normalize cell_hist and then multiply with corresponding weight        
            cell_hist = cell_hist / sum(cell_hist) * layerWeight(l, L);
            % Concatenate all the histograms together
            h(index*K+1 : (index+1)*K) = cell_hist(:);
            
            index = index+1;
            
        end
    end

end

end


% Compute the weight for every layer
function [weight] = layerWeight(l, L)

if(l==0 || l==1)
    weight = 2^(-L);
else
    weight = 2^(l-L-1);
end

end

        
  