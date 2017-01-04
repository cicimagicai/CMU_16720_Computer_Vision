% Run the ransacF function to selset a point in the 1st image and 
% visualize the corresponding epipolar line in the second image

addpath('lib');
addpath('data');

i1 = imread('i1.jpg');
i2 = imread('i2.jpg');

normalization_constant = max(max(size(i1), size(i2)));

% Compute F and visulize the epipolar lines
load('noisy_correspondences.mat');
[F, inliers] = ransacF(pts1, pts2, normalization_constant);
displayEpipolarF(i1, i2, F);
fprintf('The fundamental matrix F:\n');
disp(F);
