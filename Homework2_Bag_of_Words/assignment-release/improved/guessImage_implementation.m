GG% guessImage_implementation:
% Randomly select 3 test images from the testImagePaths to guess the name
% of this image

imageDir = '../images/';
load('traintest.mat');

% Set the number of testImages you want to guess
testImages_number = 5;

for i = 1:testImages_number
    % Randomly select certain number of images from the testImagePaths
    index = randi([1 length(testImagePaths)], 1, testImages_number);
    % Get the test image path
    imagePath = [imageDir testImagePaths{index(i)}];

    disp(imagePath);
    % Guess what this image is
    guessImage(imagePath);
end