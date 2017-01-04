function genNovelView

	addpath(genpath('.'));
	load('data/K.mat'); %intrinsic parameters K
	i1 = imread('data/i1.jpg');
	i2 = imread('data/i2.jpg');
    
    % Initialize parameters
    threshDist1 = 0.05;
    threshDist2 = 0.03;
    thetaX = 40 * pi / 180;
    thetaY = 0;
    thetaZ = 0;
	normalization_constant = max(max(size(i1), size(i2)));
    
    % Compute F and inliers
    load('noisy_correspondences.mat');
    [F, inliers] = ransacF(pts1, pts2, normalization_constant);
    
    pts1 = pts1(:, inliers);
    pts2 = pts2(:, inliers);
    
    % Generate the camera matrix 
    M1 = K * eye(3, 4);
    M2 = camera2(F, K, K, pts1, pts2);
    M3 = genM(K, thetaX, thetaY, thetaZ);
    
    % Compute the 3D location P of selected point correspondences
    P = triangulate(M1, pts1, M2, pts2);
    
    % Generate two main planes
    [smith_south_plane, inliers1] = ransacPlane(P, threshDist1);
    P(:, inliers1) = [];
    [smith_west_plane, ~] = ransacPlane(P, threshDist2);
    
    % Draw novel view 1 of Smith Hall from camera1 viewpoint
    figure(1);
    frame1 = drawNovelView(smith_south_plane, smith_west_plane, M1);
    imshow(frame1);
    
    % Draw novel view 2 of Smith Hall from camera2 viewpoint
    figure(2);
    frame2 = drawNovelView(smith_south_plane, smith_west_plane, M2);
    imshow(frame2);
    
    % Draw novel view 3 of a higher view of Smith Hall from a higher angle
    figure(3);        
    frame3 = drawNovelView(smith_south_plane, smith_west_plane, M3);
    imshow(frame3);
end

