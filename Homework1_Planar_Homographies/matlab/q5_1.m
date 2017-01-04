function [ H2to1, warpedImg, panoImg ] = q5_1_1(img1, img2, pts)

%*****************************Q3.1(a)**********************************

% Obtain p1 and p2 according to pts
p1 = pts(1:2,:);
p2 = pts(3:4,:);

% Compute H and save it
H2to1 = computeH(p1, p2);
save('q5_1.mat', 'H2to1');

% Append p2 with the row of 1's
p2 = [p2; ones(1, size(pts, 2))];
% Compute the corresponding p2 with homography and normalize it
p2_corresponding = H2to1 * p2;
p2_corresponding = bsxfun(@rdivide, p2_corresponding, p2_corresponding(3, :));
p2_corresponding = p2_corresponding(1:2, :);

save('q5_1_warpedFeatures.mat', 'p2_corresponding');

% Compute Root Mean Squared Error
RMSE = sqrt(2*mean(mean(p1 - p2_corresponding).^2));
disp(['Root Mean Squared Error:' num2str(RMSE)]);


%*****************************Q3.1(b)**********************************

% Warp img2 and save it(set fill_value = 0)
warpedImg = warpH(img2, H2to1, [size(img1, 1) 3000], 0);
imwrite(warpedImg, 'q5_1.jpg');

% Append the size of img1 corresponding to the size of warpedImg.
img1_append = uint8(zeros([[size(img1, 1) 3000] 3]));
img1_append(1:size(img1,1),1:size(img1,2),:) = img1;
    
% Get the mask of 3 channels for warpedImg, whose region won't be overlaped by the
% img1_append(considering fill_value=0).
M1 = img1_append(:,:,1) == 0;
M2 = img1_append(:,:,2) == 0;
M3 = img1_append(:,:,3) == 0;
M_warpedImg = M1.*M2.*M3;
% The corresponding mask of 3 channels for img1_append, whose region will overlap
% to the warpedImg.
M_img1_append= not(M_warpedImg);
    
% Overlap the warpImg with the img1_append by mask
panoImg = uint8(zeros(size(warpedImg)));
panoImg(:,:,1) = uint8(M_img1_append).*img1_append(:,:,1) + uint8(M_warpedImg).*warpedImg(:,:,1);
panoImg(:,:,2) = uint8(M_img1_append).*img1_append(:,:,2) + uint8(M_warpedImg).*warpedImg(:,:,2);
panoImg(:,:,3) = uint8(M_img1_append).*img1_append(:,:,3) + uint8(M_warpedImg).*warpedImg(:,:,3);

% Save panoImg
imwrite(panoImg, 'q5_1_pan.jpg');

end

