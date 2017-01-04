% This script is used for generating the top 10 visual words

% Where the top10 visual words images are located
imageDir = '../Q4.2/top10VisualWords_images'; 
% Where the top10 visual words wordMap are located
targetDir = '../Q4.2/top10VisualWords_wordmap';
pdfDir = '../Q4.2/top10VisualWords';

load('average_Patch.mat');
load('top10VisualWords_imagesPaths.mat');

layNum = 1;
dictionarySize = 150;

for i = 1:length(top10VisualWords_imagesPaths)
%for i = 3:4
    % Load the image
    imgPath = top10VisualWords_imagesPaths{i};
    top10VisualWords_image = imread(fullfile(imageDir, imgPath));
    
    % Get the wordMap of the trainImg
    img_matPath = strrep(imgPath, 'jpg', 'mat');
    img_matPath = fullfile(targetDir, img_matPath);    
    img_mat = load(img_matPath);
    wordMap = img_mat.wordMap;
    
   
    % Calculate the histogram
    h = getImageFeaturesSPM(layNum, wordMap, dictionarySize);
    % Sort the histogram and get the index in descending order
    [value, index] = sort(h, 'descend');
    % Get the top 10 visualWords
    top10 = index(1:10);
    top10Patches = average_Patch(top10);
    
    %disp(top10VisualWords_imagesPaths{i});
    
    % Plot the image and its corresponding top
    figure(2*i-1)
    imshow(top10VisualWords_image);
    figure(2*i)
    imdisp(top10Patches,'Size', 5);
    
    
    visualWords_Path = strrep(imgPath, '.jpg', '');
    visualWords_Path = fullfile(pdfDir, visualWords_Path);
    

    set(gcf,'position',[0 0 400 400]);
    set(gcf, 'Color', 'w');

    export_fig(sprintf('../Q4.2/top10VisualWords/visualWords_%d.pdf',i));


end