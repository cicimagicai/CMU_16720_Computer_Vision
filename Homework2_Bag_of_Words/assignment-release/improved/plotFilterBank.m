% This script is used for ploting the filter from filterBank

load('dictionary.mat');
addpath('altmany-export_fig-8016f6a');

% The index of Prewitt Filter and Sobel Filter
index = [12 13 14 15 27 28 29 30 42 43 44 45];

figure(1);
for i = 1:length(index)
    subplot(2,6,i);
    %surf(filterBank{index(i)});
    imagesc(filterBank{index(i)});

end

set(gcf,'position',[0 0 600 200]);
set(gcf, 'Color', 'w');
print -dpdf filterBank.pdf
export_fig filterBank.pdf