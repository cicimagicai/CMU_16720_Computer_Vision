% Create by chenjx65 on 2016-11-1
clear all;
addpaths;

load('data/pooh/rects_frm992.mat');
poohPath = 'data/pooh/testing';

% Initialize and obtain frame
first = 992;
last = 3000;
alpha = 0.3;
length = last - first + 1;
rectInit = {rect_lear, rect_leye, rect_nose, rect_rear, rect_reye};
rectUpdate = rectInit;

It = cell(1, length);
for i = 1 : length
    It{i} = imread(fullfile(poohPath, sprintf('image-%04d.jpg', i + first - 1))); 
end

% Open video writer
vidname = 'pooh_lk_extra.avi';
vidout = VideoWriter(vidname);
vidout.FrameRate = 10;
open(vidout);
% Add frames to video
for i = 2 : length - 1
    % Compute displacement for 5 rectangulars by LK
    for j = 1 : 5
                      
        % Question 2.1.3 Extra Credit
        %************************************************************
        % Utilize the combination of rectUpdate and rectInit
        [u1, v1] = LucasKanade(It{i-1}, It{i}, rectUpdate{j});
        [u2, v2] = LucasKanade(It{i}, It{i+1}, rectInit{j});
        
        % Use interpolation to combine the translation of u1, u2 and v1, v2
        u = alpha*u1 + (1-alpha)*u2;
        v = alpha*v1 + (1-alpha)*v2;
        rectInit{j} = rectInit{j} + [u, v, u, v];
        %*************************************************************
        
        % Adjust rectangular and update to draw        
        rectUpdate{j}(1) = max(0, rectInit{j}(1));
        rectUpdate{j}(2) = max(0, rectInit{j}(2));
        rectUpdate{j}(3) = min(size(It{i+1}, 2), rectInit{j}(3));
        rectUpdate{j}(4) = min(size(It{i+1}, 1), rectInit{j}(4));             
    end
    hf = figure(1); clf; hold on;
    imshow(It{i+1});
    for j = 1 : 5
        rect = [rectUpdate{j}(1:2), rectUpdate{j}(3:4)-rectUpdate{j}(1:2)];
        %rect = [rectInit{j}(1:2), rectInit{j}(3:4)-rectInit{j}(1:2)];
        drawRect(rect, 'r', 5);
    end
    frameNum = i + first;

    text(80, 100, ['Frame ', num2str(frameNum)], 'color', 'y', 'fontsize', 100);
    title('Pooh tracker with Lucas-Kanade Tracker');
    hold off;
    % Write and resize a frame to video
    frm = getframe;
    writeVideo(vidout, imresize(frm.cdata, 0.5));
end

% Close video writer
close(vidout);
close(1);
fprintf('Video saved to %s\n', vidname);
