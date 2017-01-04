% Created by chenjx65 on 2016-10-13.

function [boundingBoxes] = batchDetectImageESVM(imageNames, models, params)

imageDir = '../../data/voc2007';
% Initialize
N = length(imageNames);
boundingBoxes = cell(1, N);
% Create boundingBoxes for each image
for i = 1:N
    I = imread(fullfile(imageDir, imageNames{i}));
    boundingBoxes{i} = esvm_detect(I, models, params);
end
end