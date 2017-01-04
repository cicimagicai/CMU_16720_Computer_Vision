% Create by chenjx65 on 2016-11-5
function F = genFeatureMatrix(perturbedConfigurations, images, m, n)

% Initialize
F =[];

for i = 1 : m
    % Extract siftFeatures for each image and update F
    siftFeatures = siftwrapper(images{i}, perturbedConfigurations{i});    
    F = [F; reshape(siftFeatures, 640, n)'];
end
end
