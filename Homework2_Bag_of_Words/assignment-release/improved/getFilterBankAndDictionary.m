function [filterBank,dictionary] = getFilterBankAndDictionary(imPaths)

% Initialize parameters
K = 200;
alpha = 20;

% Obtain filterBank
filterBank = createFilterBank();

% T is the number of training images
T = length(imPaths);
%T = 1000;
% N is the number of filter responses
N = length(filterBank);

% Create the αT × N*3 filterResponses to collect over all the images
filterResponses = zeros(alpha*T, N*3);

for i = 1:T
    % Load each image
    I = imread(imPaths{i});
    
    % Calculate the responses of each image
    % imgResponses is a H*W × 145 matrix
    imgResponses = extractFilterResponses(I, filterBank);
    
    % Detect the SURF Features and get the corrdinate of strongest points
    points = detectSURFFeatures(I(:,:,1));
    strongestPoints = points.selectStrongest(alpha);
    pointsCor = round(strongestPoints.Location);
    
    if size(pointsCor, 1) == 0
        pointsCor = randi([1 min(size(I))], alpha, 2);
    elseif size(pointsCor, 1) < alpha
        
        %***********Strongest Points + Random Points*******************
        %count = alpha - size(pointsCor, 1);
        %pointsCor_append = randi([1 min(size(I))], count, 2);
        %pointsCor = [pointsCor; pointsCor_append];
        
        %***********Strongest Points Only********************************
        copy = ceil((alpha - size(pointsCor, 1))/size(pointsCor, 1)) + 1;
        cor_append = repmat(pointsCor, copy, 1);
        pointsCor = cor_append(1:alpha, :);
        
    end
    
    row_index = ((pointsCor(:,1)-1)*size(I,1) + pointsCor(:, 2))';
    % Select alpha random imgResponses by randperm function
    alphaResponses = imgResponses(row_index, :);
    
    % Set the alphaResponses into the filterResponses
    filterResponses((i-1) * alpha + 1 : i*alpha, :) = alphaResponses;
end    

% Cluster the filterResponses by calling kmeans function
% dictrionary is K × 145 matrix
[unused, dictionary] = kmeans(filterResponses, K, 'EmptyAction', 'drop');

end
