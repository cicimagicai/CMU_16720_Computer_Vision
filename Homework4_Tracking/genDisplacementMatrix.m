% Create by chenjx65 on 2016-11-5
function D = genDisplacementMatrix(perturbedConfigurations, annotations, m, n)

% Initialize
D =[];

for i = 1 : m
    % Obtain annotation and perturbedConfiguration for each frame
    annotation = reshape(annotations(i, 2 : end), [2, 5])';
    perturbedConfiguration = perturbedConfigurations{i}(1:2, :)';

    % Calculate displacement and update D
    displacement = repmat(annotation, n, 1) - perturbedConfiguration;
    D = [D; reshape(displacement', [10, n])'];   
end
end