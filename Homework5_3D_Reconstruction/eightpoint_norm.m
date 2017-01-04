function F = eightpoint_norm(pts1, pts2, normalization_constant)

% Compute Hartley's normalization transformation T and the corresponding
% points pst1 and pst2
T = eye(3) / normalization_constant;
T(3, 3) = 1;
pts1 = pts1 / normalization_constant;
pts2 = pts2 / normalization_constant;

% Use homogeneous linear least squares to estimate the matrix F
x1 = pts1(1, :)';
y1 = pts1(2, :)';
x2 = pts2(1, :)';
y2 = pts2(2, :)';
A = [x2.*x1 x2.*y1 x2 y2.*x1 y2.*y1 y2 x1 y1 ones(size(x1))];

[~, ~, V] = svd(A);
F = reshape(V(:, 9), 3, 3)';

% Compute the singular value decomposition of matrix F and set S(3, 3) = 0
[U, S, V] = svd(F);
S(3, 3) = 0;
F = U * S * V';

% Output the fundamental matrix F
F = T' * F * T;

end

