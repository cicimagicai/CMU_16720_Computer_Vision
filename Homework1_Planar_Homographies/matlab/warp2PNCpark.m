% Jiaxin Chen
% Q 4.2
% 2015

function [img_Jiaxin_warped, img_PNCpark_Jiaxin] = warp2PNCpark(img_PNCpark, img_Jiaxin, p1, p2)

% Transpose p1 and p2 to targeted format
p1 = p1';
p2 = p2';

% Compute H with input p1, p2
H2to1 = computeH(p1, p2);

% Compute warped image by using warpH function
img_Jiaxin_warped = warpH(img_Jiaxin, H2to1, size(img_PNCpark(:, :, 1)), 0);

% Get the mask of 3 channels for PNCpark image, whose region won't be overlaped by
% the warped image.
M1 = (img_Jiaxin_warped(:,:,1) == 0);
M2 = (img_Jiaxin_warped(:,:,2) == 0);
M3 = (img_Jiaxin_warped(:,:,3) == 0);
M_PNCpark = M1 .* M2 .* M3;

% The corresponding mask of 3 channels for warped image, whose region will overlap
% to the PNCpark image.
M_Jiaxin = not(M_PNCpark);
    
% Overlap the PNCpark image with the warped image by mask
img_PNCpark_Jiaxin(:,:,1) = uint8(M_PNCpark).*img_PNCpark(:,:,1) + uint8(M_Jiaxin).*img_Jiaxin_warped(:,:,1);
img_PNCpark_Jiaxin(:,:,2) = uint8(M_PNCpark).*img_PNCpark(:,:,2) + uint8(M_Jiaxin).*img_Jiaxin_warped(:,:,2);
img_PNCpark_Jiaxin(:,:,3) = uint8(M_PNCpark).*img_PNCpark(:,:,3) + uint8(M_Jiaxin).*img_Jiaxin_warped(:,:,3);