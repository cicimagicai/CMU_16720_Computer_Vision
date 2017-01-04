% Created by chenjx65 on 2016-10-13.

% Q3.3.1

addpath(genpath('../utils'));
addpath(genpath('../lib/esvm'));
addpath(genpath('../external'));
load('../../data/bus_esvm.mat');
load('../../data/bus_data.mat');
imageDir = '../../data/voc2007/';

% Parameters
alpha = 100;
K = 100;
resize = 100;

% Create filterBank
filterBank = createFilterBank();

% Initialize
T = length(modelImageNames);
N = length(filterBank);
filterResponses = zeros(alpha*T, N*3);
IResizedBoxes = cell(1, T);
averageImgs = cell(1, K);
alphaImgIndex = zeros(alpha*T, 1);
clusterImg = zeros(1, K);

%% Calculate filterResponses and cluster them.
for i = 1:T
    % Obtain resized box of each image
    I = imread([imageDir, modelImageNames{i}]);   
    imgBBox = modelBoxes{i};   
    IBox = I(imgBBox(2): imgBBox(4), imgBBox(1): imgBBox(3), :);
    IResizedBoxes{i} = imresize(IBox, [resize resize]);
    alphaImgIndex((i-1)*alpha+1: i*alpha) = i*ones(alpha, 1);
    
    % Select alpha imgResponses into filterResponses
    imgResponses = extractFilterResponses(IBox, filterBank);    
    alphaResponses = imgResponses(randperm(size(imgResponses, 1), alpha), :);
    filterResponses((i-1)*alpha+1 : i*alpha, :) = alphaResponses;   
end
% Cluster filterResponses by kmeans function
[clusterIndex, ~, ~, clusterDistance] = kmeans(filterResponses, K, 'EmptyAction', 'drop');

%% Calculate the averageImg for each cluster 
for i = 1:K
    averageImg = zeros(resize, resize, 3);
    imgIndex = alphaImgIndex(clusterIndex == i);  
    len = length(imgIndex);
    for j = 1:len
        averageImg = averageImg + double(IResizedBoxes{imgIndex(j)});
    end  
    averageImgs{i} = uint8(averageImg / len);   
end
imdisp(averageImgs, 'Size', 10);

set(gcf,'position',[0 0 800 800]);
set(gcf, 'Color', 'w');
print -dpdf q3_3_1.pdf
export_fig q3_3_1.pdf

%% Calculate boundingboxes and AP
for i = 1:K
    [~, pos] = min(clusterDistance(:, i));
    clusterImg(i) = alphaImgIndex(pos);
end
refined_models = models(unique(clusterImg));                                            
params = esvm_get_default_params();                                                               
params.detect_levels_per_octave = 3;                                                              
[boundingBoxes] = batchDetectImageESVM(gtImages, refined_models, params);                         
[~,~,ap] = evalAP(gtBoxes, boundingBoxes);                                                         
fprintf('K = %i, AP = %d\n',K,ap);    

