% Created by chenjx65 on 2016-10-13.

% Q3.2.2

addpath(genpath('../utils'));
addpath(genpath('../lib/esvm'));
load('../../data/bus_esvm.mat');
load('../../data/bus_data.mat');
params = esvm_get_default_params();

% Initialize
lpo = [3, 5, 10];
len = length(lpo);
recall = cell(1,len);
precion = cell(1,len);
AP = zeros(1,len);

for i = 1:len   
    % Update params and compute the corresponding boundingBoxes.
    params.detect_levels_per_octave = lpo(i);
    [boundingBoxes] = batchDetectImageESVM(gtImages, models, params);
    [recall{i}, precion{i}, AP(i)] = evalAP(gtBoxes,boundingBoxes);
end

% plot AP vs. lpo graph
plot(lpo, AP);
title('AP vs. LPO');
xlabel('LPO');
ylabel('AP');


