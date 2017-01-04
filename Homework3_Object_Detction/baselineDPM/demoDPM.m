%% setting path and load model
addpath(genpath('../utils'));
addpath(genpath('../lib/dpm'));
addpath(genpath('../external'));
load('../../data/bus_dpm.mat');

imgPath = cell(3, 1);
imgPath{1} = '../../data/voc2007/008360.jpg';
imgPath{2} = '../../data/voc2007/009105.jpg';
imgPath{3} = '../../data/voc2007/009126.jpg';

for i = 1:length(imgPath)
    %% Object detection via DPMs
    I = imread(imgPath{i});
    detectionBoxes = imgdetect(I,model);
    figure; showboxes(I,  detectionBoxes);      %% show detected bounding boxes.

    %% Non-Maximum suppression
    bestBBox = nms(detectionBoxes,200,1);
    figure; hold on; image(I); axis ij; hold on;
    showboxes(I,  bestBBox);

    %% Draw image
    set(gcf,'position',[0 0 800 800]);
    set(gcf, 'Color', 'w');
    export_fig(sprintf('q22_result%d.jpg',i));
end