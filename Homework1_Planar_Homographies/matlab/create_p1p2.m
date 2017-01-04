% Jiaxin Chen
% Q 4.2
% 2016

img1 = imread('pnc.jpg');
img2 = imread('pnc_tomap.jpg');
cpselect('pnc.jpg','pnc_tomap.jpg');

% use cpselect to save 2 sets of point pairs
% ... move to p1 and p2 as required

save('Q4.2.p1p2.mat', 'p1', 'p2') % save it

