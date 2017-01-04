function [filterBank,dictionary] = getFilterBankAndDictionary(imPaths)

% Initialize parameters
K = 150;
alpha = 100;

% Obtain filterBank
filterBank = createFilterBank();

% T is the number of training images
T = length(imPaths);
% N is the number of filter responses
N = length(filterBank);

% Create the αT × N*3 filterResponses to collect over all the images
filterResponses = zeros(alpha*T, N*3);

for i = 1:T
    % Load each image
    I = imread(imPaths{i});
    
    % Calculate the responses of each image
    % imgResponses is a H*W × 99 matrix
    imgResponses = extractFilterResponses(I, filterBank);
    
    % Select alpha random imgResponses by randperm function
    alphaResponses = imgResponses(randperm(size(imgResponses, 1), alpha), :);
    
    % Set the alphaResponses into the filterResponses
    filterResponses((i-1) * alpha + 1 : i*alpha, :) = alphaResponses;
end    

% Cluster the filterResponses by calling kmeans function
% dictrionary is K × 99 matrix
[unused, dictionary] = kmeans(filterResponses, K, 'EmptyAction', 'drop');

end
