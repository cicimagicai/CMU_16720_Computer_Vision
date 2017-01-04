% Create by chenjx65 on 2016-11-5
function [updateConfigurations,W] = learnMappingAndUpdateConfigurations(perturbedConfigurations, D, F, m, n)

% calculate model weight and updateConfiguratons
W = learnLS(F, D);
updateConfigurations = perturbedConfigurations;

for i = 1 : m   
    % Calculate siftFeature and displacement 
    perturbedConfiguration = reshape(perturbedConfigurations{i}(1:2, :), [10, n])';    
    siftFeature = F((i-1)*n+1 : i*n, :);
    displacement = siftFeature * W;
    updateConfiguration = perturbedConfiguration + displacement;    
    updateConfigurations{i}(1:2, :) = reshape(updateConfiguration', [2, n*5]);      
end
end