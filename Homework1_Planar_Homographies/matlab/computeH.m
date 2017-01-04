% Jiaxin Chen
% Q 2.1
% 2016

function H2to1 = computeH(p1, p2)

% The number of points
N = size(p1, 2); 
% Set A to the required size
A = zeros(2*N, 9); 
% Append p2 with a column vector of 1's to Nx3 matrix
p2_append = [p2; ones(1, N)];

for i = 1 : N
    % Get the coordinates of p1
    u = p1(1, i);
    v = p1(2, i);
    % Set the corresponding coordinates value in A
    A(2*i - 1, :) = [p2_append(:, i)' 0 0 0 -u*(p2_append(:, i)')];
    A(2*i, :) = [0 0 0 p2_append(:, i)' -v*(p2_append(:, i)')];
end

% Compute SVD by using eig
[V, D] = eig((A')*A);
% Get the minimal eigenvalue
[eigenvalue_min, position] = min(diag(D));

% Get the minimal eigenvector corresponding to the minimal eigenvalue.
H = V(:, position);
% Reshape H to 3x3 matrix
H2to1 = reshape(H,3,3)';
