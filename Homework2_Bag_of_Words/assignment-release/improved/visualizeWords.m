imageDir = '../images'; %where all images are located
targetDir = '../wordmap';%where we will store visual word outputs 
load('traintest.mat');
addpath('altmany-export_fig-8016f6a');

patchSize = 9;
patchCenter = ceil(patchSize / 2);

num_images = length(trainImagePaths);
dictionarySize = size(dictionary, 1);
visualWords_number = zeros(1, dictionarySize);
average_Patch = cell(1, dictionarySize);

for i = 1:dictionarySize
    average_Patch{i} = zeros(patchSize, patchSize, 3);
end


for index = 1:num_images   
    % Load the trainImg
    imgPath = trainImagePaths{index};
    trainImg = imread(fullfile(imageDir, imgPath));
    
    % Get the wordMap of the trainImg
    img_matPath = strrep(imgPath, 'jpg', 'mat');
    img_matPath = fullfile(targetDir, img_matPath);    
    img_mat = load(img_matPath);
    wordMap = img_mat.wordMap;
    
    % Get the H × W image size
    H = size(wordMap, 1);
    W = size(wordMap, 2);
    
    % Traverse pixel in the image
    for i = patchCenter : (H - patchCenter + 1)
        for j = patchCenter : (W - patchCenter + 1)
            % Get the certain 9 × 9 pixel patch
            patch = trainImg((i-patchCenter+1):(i+patchCenter-1), (j-patchCenter+1):(j+patchCenter-1),:);
            % Get the index of corresponding visualWord in the dictionary
            visualWord_index = wordMap(i,j);
            % Add the patch to the corresponding visualWord_index patch
            average_Patch{visualWord_index} = average_Patch{visualWord_index} + double(patch);
            visualWords_number(visualWord_index) = visualWords_number(visualWord_index) + 1;
        end
    end
end

% Calculate the average_patch
for i = 1:dictionarySize
    if visualWords_number(i) > 0
        average_Patch{i} = average_Patch{i} / visualWords_number(i);
    end
    average_Patch{i} = uint8(average_Patch{i});
end


save('average_Patch.mat', 'average_Patch');
imdisp(average_Patch, 'Size', 20);

set(gcf,'position',[0 0 800 800]);
set(gcf, 'Color', 'w');
print -dpdf visualization.pdf
export_fig visualization.pdf








