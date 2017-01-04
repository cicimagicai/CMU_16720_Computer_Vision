function [F, inliers] = ransacF(pts1, pts2, normalization_constant)

% Initialize parameters
iter = 10000;
threshDist = 0.001;
inliersNum = 0;
minDist = 1;
pointsNum = size(pts1, 2);

for i = 1 : iter          
   % Select 7 points randomly
   index = randperm(pointsNum, 7);
   pts1Random = pts1(:, index);
   pts2Random = pts2(:, index);

   % Calculate the fundamental matrix F_Noisy
   F_Noisy = sevenpoint_norm(pts1Random, pts2Random, normalization_constant);
   
   for j = 1 : length(F_Noisy)
       currentInliers = [];
       totalDist = 0;
       for k = 1 : pointsNum
           % Compute the currentDist between the points with the fitting line
           p1 = [pts1(:, k); 1];
           p2 = [pts2(:, k); 1];           
           currentDist = abs(p2' * F_Noisy{j} * p1);       
           
           % Compute the inliers with currentDist smaller than threshDist
           if (currentDist < threshDist)
               currentInliers = [currentInliers, k];
           end
           totalDist = totalDist + currentDist;                       
       end    
 
       % Update the inliers and minDist if better model is found
       currentNum = size(currentInliers, 2);
       if((currentNum >= inliersNum && totalDist < minDist) || (currentNum > inliersNum))
           F = F_Noisy{j};
           inliers = currentInliers;
           inliersNum = currentNum;
           minDist = totalDist;
           fprintf('ransacF: %i inliers, %d minDist\n', length(inliers), minDist);
       end   
   end  
end
end

