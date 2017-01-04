% Create by chenjx65 on 2016-11-5
function perturbedConfigurations = genPerturbedConfigurations(singleFrameAnnotation,meanShape, n, scalesToPerturb)

% Initialize 
perturbedConfigurations = zeros(4, n*5);     

% Calculate random translations and scales
translateX = 10 * randn(1, 10*n);
translateY = 10 * randn(1, 10*n);
index = find((sqrt(translateX.^2 + translateY.^2)) <= 10);
translateX = translateX(index(1 : n));
translateY = translateY(index(1 : n));
translations = [translateX ; translateY]';
scales = scalesToPerturb(randsample(length(scalesToPerturb), n, true));

for i = 1:n
    % Perturb the meanShape by translation and scaling.
    centerShift = mean(singleFrameAnnotation) - mean(meanShape);
    updateMeanShape = bsxfun(@plus, meanShape, centerShift);
    updateMeanShape = updateMeanShape * scales(i);
    updateMeanShape = bsxfun(@plus, updateMeanShape, translations(i, :));
    scale = findscale(updateMeanShape, singleFrameAnnotation);

    % Generate perturbedConfigurations of x, y locations and scale of SIFT
    perturbedConfigurations(1:2, 5*(i-1)+1 : 5*i) = (updateMeanShape * scale)';
    perturbedConfigurations(3, 5*(i-1)+1 : 5*i) = [7 4 4 10 10] * scale;
end
end
    

