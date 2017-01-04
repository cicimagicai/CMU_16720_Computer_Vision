% Run the sevenpoint_norm function to selset a point in the 1st image and 
% visualize the corresponding epipolar line in the second image

addpath('lib');
addpath('data');
load('clean_correspondences.mat');

i1 = imread('i1.jpg');
i2 = imread('i2.jpg');

pts1 = pts1(:, 1:7);
pts2 = pts2(:, 1:7);
normalization_constant = max(max(size(i1), size(i2)));
F = sevenpoint_norm(pts1, pts2, normalization_constant);

for i = 1 : length(F)

    displayEpipolarF(i1, i2, F{i});
    fprintf('The fundamental matrix F%d:\n', i);
    disp(F{i});
end
    
