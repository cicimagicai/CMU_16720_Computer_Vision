% Created by chenjx65 on 2016-10-12.

function [CCenters,CMemberships] = MeanShift(data,bandwidth,stopThresh)
% Intialize X and associated positive weight
X = data(:, 1:end-1);
w = data(:, end);
[N, F] = size(X);
XNew = zeros(N, F);

for i = 1:N
    Xi = X(i, :);  
    while 1
        % Calculate the distance between current point and other point.
        distance = sqrt(sum(bsxfun(@minus, X, Xi).^2, 2));
        % Get the index of points within the bandwidth and calculate Xmean.
        index = distance < (bandwidth / 2);
        Xmean = sum(bsxfun(@times, w(index,:), X(index,:)))/sum(w(index,:));
        % Check convergence of the Mean-Shift algorithm and update Xmean. 
        if norm(Xmean - Xi) < stopThresh
            break;
        end   
        Xi = Xmean;        
    end
    XNew(i, :) = Xmean;
end

% Initialize and define merge threshold
CMemberships = zeros(N, 1);
CCenters = XNew(1, :);
mergeThresh = norm(max(X) - min(X)) / 100;
for i = 1:N
    centerDist = sqrt(sum(bsxfun(@minus, CCenters, XNew(i, :)).^2, 2));
    [certerDistMin, pos] = min(centerDist);
    % Merge to the corresponding cluster
    if certerDistMin < mergeThresh
        CMemberships(i) = pos;
    % Create a new cluster
    else
        CCenters = [CCenters; XNew(i, :)];
        CMemberships(i) = size(CCenters, 1);
    end
end
save('q21_result.mat', 'CCenters', 'CMemberships');
end