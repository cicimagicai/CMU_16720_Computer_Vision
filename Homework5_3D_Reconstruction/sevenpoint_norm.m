function F = sevenpoint_norm(pts1, pts2, normalization_constant)

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
F1 = reshape(V(:, 8), 3, 3)';
F2 = reshape(V(:, 9), 3, 3)';

% Calculate lambda according to the rank-2 constraint
syms lambda;
coefficients = sym2poly(det(lambda * F1 + (1-lambda) * F2));
lambda = roots(coefficients);
lambda = lambda(lambda == real(lambda));

n = length(lambda);
F = cell(1, n);

% Output the fundamental matrix F
for i = 1 : n
   F{i} = lambda(i) * F1 + (1-lambda(i)) * F2;
   F{i} = T' * F{i} * T;
end


end

