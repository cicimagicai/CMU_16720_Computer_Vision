function [plane, inliers] = ransacPlane(P, threshDist)

% Initialize parameters
iter = 10000;
inliersNum = 0;
minDist = 100;
pointsNum = size(P, 2);

for i = 1 : iter          
   % Select 3 points randomly
   index = randperm(pointsNum, 3);
   planePoints = P(:, index)';

   % Generate plane
   normal = cross(planePoints(2, :) - planePoints(1, :), planePoints(3, :) - planePoints(1, :));
   currentPlane = [normal -dot(normal, planePoints(1, :))];
   currentPlane = currentPlane / norm(currentPlane);
   
   currentInliers = [];
   totalDist = 0;
   for k = 1 : pointsNum
       % Compute the currentDist between the points with the fitting line        
       currentDist = abs(dot([P(:, k)', 1], currentPlane));
       currentDist = currentDist / norm(currentPlane(1:3));       

       % Compute the inliers with currentDist smaller than threshDist
       if (currentDist < threshDist)
           currentInliers = [currentInliers, k];
       end
       totalDist = totalDist + currentDist;                       
   end    

   % Update the inliers and minDist if better model is found
   currentNum = size(currentInliers, 2);
   if((currentNum >= inliersNum && totalDist < minDist) || (currentNum > inliersNum))
       plane = currentPlane';
       inliers = currentInliers;
       inliersNum = currentNum;
       minDist = totalDist;
       fprintf('ransacPlane: %i inliers, %d minDist\n', length(inliers), minDist);
   end   
end
end

