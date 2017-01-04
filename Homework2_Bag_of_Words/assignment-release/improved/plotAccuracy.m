% plotAccurary:
% Plot the graph of k vs classification accuracy

addpath('altmany-export_fig-8016f6a');

% k in knnClassify
k = [1 2 3 5 8 10 12 13 14 15 16 20 32 64];
% The corresponding accuracy computed by the evaluateRecognitionSystem.m
accuracy = [0.7103 0.6760 0.7290 0.7508 0.7352 0.7477 0.7570 0.7601...
            0.7664 0.7664 0.7632 0.7570 0.7508 0.7196];

figure;
plot(k, accuracy, 'r-');
xlabel('k');
ylabel('classification accuracy');
title('The graph of k vs classification accuracy');

set(gcf, 'Position', [0 0 600 400]);
set(gcf, 'Color', 'w');
print -dpdf k_accuracy.pdf
export_fig k_accuracy.pdf