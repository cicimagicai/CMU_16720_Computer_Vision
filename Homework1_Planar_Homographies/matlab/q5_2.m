function [ H2to1, panoImg ] = q5_2( img1, img2, pts)

% Obtain p1 and p2 according to pts
p1 = pts(1:2,:);
p2 = pts(3:4,:);

% Compute H and save it
H2to1 = computeH(p1, p2);

% Obtain the 4 vertices of img2
img2_vertices = ones(3, 4);
img2_vertices(:, 1) = [1; 1; 1];
img2_vertices(:, 2) = [size(img2, 2), 1, 1];
img2_vertices(:, 3) = [1, size(img2, 1), 1];
img2_vertices(:, 4) = [size(img2, 2), size(img2, 1), 1];

% Compute the corresponding vertices of img2 with homograpy and normalize
img2_vertices_corresponding = H2to1 * img2_vertices;
img2_vertices_corresponding = bsxfun(@rdivide, img2_vertices_corresponding, img2_vertices_corresponding(3, :));

% Compute the x and y extremnum for the initial size
x_max = max(size(img1,2),max(img2_vertices_corresponding(1,:)));
y_max = max(size(img1,1),max(img2_vertices_corresponding(2,:)));
x_min = min(1, min(img2_vertices_corresponding(1,:)));
y_min = min(1, min(img2_vertices_corresponding(2,:)));

% Compute the initial size of the panoImg
width = x_max - x_min;
height = y_max - y_min;

% Convert the initial size into the fixed size
width_fixed = 1280;
height_fixed = round(width_fixed * height / width);

% Compute the scale alpha and belta
alpha = width_fixed / width;
belta = alpha;

% Compute x and y axis translation
x_translation = min(min(img2_vertices_corresponding(1, :)), 0);
y_translation = min(min(img2_vertices_corresponding(2, :)), 0);

% Combine into matrix M
M = [alpha 0 abs(x_translation)*alpha; 0 belta abs(y_translation)*belta; 0 0 1];

% Warp img1 and img2 into the fixed size
warpedImg1 = warpH(img1, M, [height_fixed, width_fixed], 0);
warpedImg2 = warpH(img2, M * H2to1, [height_fixed, width_fixed], 0);

% Append the size of img1 corresponding to the size of warpedImg.
warpedImg1_append = uint8(zeros([[height_fixed width_fixed] 3]));
warpedImg1_append(1:height_fixed,1:width_fixed,:) = warpedImg1;
    
% Get the mask of 3 channels for warpedImg2, whose region won't be overlaped by the
% warpedImg1_append(considering fill_value=0).
M1 = warpedImg1_append(:,:,1) == 0;
M2 = warpedImg1_append(:,:,2) == 0;
M3 = warpedImg1_append(:,:,3) == 0;
M_warpedImg2 = M1.*M2.*M3;
% The corresponding mask of 3 channels for warpedImg1_append, whose region will overlap
% to the warpedImg1.
M_warpedImg1_append= not(M_warpedImg2);
    
% Overlap the warpImg2 with the warpedImg1_append by mask
panoImg = uint8(zeros(size(warpedImg2)));
panoImg(:,:,1) = uint8(M_warpedImg1_append).*warpedImg1_append(:,:,1) + uint8(M_warpedImg2).*warpedImg2(:,:,1);
panoImg(:,:,2) = uint8(M_warpedImg1_append).*warpedImg1_append(:,:,2) + uint8(M_warpedImg2).*warpedImg2(:,:,2);
panoImg(:,:,3) = uint8(M_warpedImg1_append).*warpedImg1_append(:,:,3) + uint8(M_warpedImg2).*warpedImg2(:,:,3);

% Save panoImg
imwrite(panoImg, 'q5_2_pan.jpg');

end

