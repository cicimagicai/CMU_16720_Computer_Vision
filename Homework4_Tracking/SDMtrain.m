function models = SDMtrain(mean_shape, annotations)
% CV Fall 2014 - Provided Code
% You need to implement the SDM training phase in this function, and
% produce tracking models for Winnie the Pooh
%
% Input:
%   mean_shape:    A provided 5x2 matrix indicating the x and y coordinates of 5 control points
%   annotations:   A ground truth annotation for training images. Each row has the format
%                  [frame_num nose_x nose_y left_eye_x left_eye_y right_eye_x right_eye_y right_ear_x right_ear_y left_ear_x left_ear_y]
% Output:
%   models:        The models that you will use in SDMtrack for tracking
%

% ADD YOUR CODE HERE  

% Parameters
poohpath = 'data/pooh/training';
scalesToPerturb = [0.8:0.2:1.2];
n = 100;
mappingNum = 5;
m = size(annotations,1);

% Initialize
images = cell(mappingNum, 1);
perturbedConfigurations = cell(1, m);
models = cell(1, mappingNum);
loss = cell(1, mappingNum);

% Calculate perturbedConfigurations
for i = 1 : m
    images{i} = imread(fullfile(poohpath, sprintf('image-%04d.jpg', annotations(i,1))));
	singleFrameAnnotation = reshape(annotations(i, 2:end), 2, 5)';
    perturbedConfigurations{i} = genPerturbedConfigurations(singleFrameAnnotation, mean_shape, n, scalesToPerturb);
end

% Calculate D, F, models and loss.
for i = 1 : mappingNum
    D = genDisplacementMatrix(perturbedConfigurations, annotations, m, n);
    F = genFeatureMatrix(perturbedConfigurations, images, m, n);
    [perturbedConfigurations,W] = learnMappingAndUpdateConfigurations(perturbedConfigurations, D, F, m, n);

    models{i} = W;
    loss{i} = norm(D(:));
    
    fprintf('loss: %d\n', loss{i});
end

end
