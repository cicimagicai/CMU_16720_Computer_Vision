% Run the eightpoint_norm function to selset a point in the 1st image and 
% visualize the corresponding epipolar line in the second image

addpath('lib');
addpath('data');

i1 = imread('i1.jpg');
i2 = imread('i2.jpg');

normalization_constant = max(max(size(i1), size(i2)));

% Compute F_Clean and visulize the epipolar lines
load('clean_correspondences.mat');
F_Clean = eightpoint_norm(pts1, pts2, normalization_constant);
displayEpipolarF(i1, i2, F_Clean);
fprintf('The fundamental matrix F_Clean:\n');
disp(F_Clean);

% Compute F_Noisy and visulize the epipolar lines
load('noisy_correspondences.mat');
F_Noisy = eightpoint_norm(pts1, pts2, normalization_constant);
displayEpipolarF(i1, i2, F_Noisy);
fprintf('The fundamental matrix F_Noisy:\n');
disp(F_Noisy);
