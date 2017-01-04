% Created by chenjx65 on 2016-10-12.

function [refinedBBoxes] = nms(bboxes, bandwidth,K)
% Calculate stopThresh and normalize the score 
stopThresh = 0.001 * bandwidth;
bboxes(:, end) = mat2gray(bboxes(:,end));
% Calculate CCenters and CMemberships by MeanShift
[CCenters,CMemberships] = MeanShift(bboxes, bandwidth, stopThresh);

refinedBBoxes = [];
M = size(CCenters, 1);
for i = 1:M     
    % Find the candidate boxes for M clusters
    candidatebboxes = bboxes(CMemberships == i, :);   
    % Choose the refinedBBoxes with the highest score 
    [~, pos] = max(candidatebboxes(:, end));                                                                                                                                          
    refinedBBoxes = [refinedBBoxes; candidatebboxes(pos, :)];                                                                                                                                          
end                                                                                               
                                                                                                  
% Obtain the top K detectors by sorting refinedBBoxes descendingly.                                                                                      
if K < size(refinedBBoxes, 1)                                                                        
    [~,index] = sort(refinedBBoxes(:, end), 'descend');                                                             
    refinedBBoxes = refinedBBoxes(index, :);                                                             
    refinedBBoxes = refinedBBoxes(1:K, :);   
end                                                                                               

end