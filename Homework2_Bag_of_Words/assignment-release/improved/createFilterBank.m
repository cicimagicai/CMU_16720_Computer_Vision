function [filterBank] = createFilterBank()
% Ishan Misra
% CV Fall 2014 - Provided Code
% Code to get a reasonable filter bank

%3 scales
scales = 1:3;

%Some arbitrary bandwidths
gaussianSigmas = [1, 2, 4];
logSigmas = [1, 2, 4, 8];
dGaussianSigmas = [2, 4];
prewittSigma = [1, 0]; % Filler for contributing to filterBank size. One horizontal, one vertical.
sobelSigma = [1, 0]; % Filler for contributing to filterBank size. One horizontal, one vertical.

    
filterBank = cell(length(scales) * (length(gaussianSigmas) + length(logSigmas) + length(dGaussianSigmas) ...
                + length(prewittSigma) + length(sobelSigma) ), 1);

ind = 1;
for scale=scales
    scaleMultiply = sqrt(2)^scale;
    %Gaussians
    for s=gaussianSigmas
        filterBank{ind} = getGaussianFilter(s*scaleMultiply);
        ind = ind + 1;
    end
    %LoG
    for s=logSigmas
        filterBank{ind} = getLOGFilter(s*scaleMultiply);
        ind = ind + 1;
    end
    %d/dx, d/dy Gaussians
    for s=dGaussianSigmas
        filterBank{ind} = filterDerivativeX(getGaussianFilter(s*scaleMultiply));
        ind = ind + 1;
        filterBank{ind} = filterDerivativeY(getGaussianFilter(s*scaleMultiply));
        ind = ind + 1;
    end
    
     % Prewitt horizontal edge-emphasizing filter
    for s = prewittSigma
        filterBank{ind} = getPrewittFilter();
        if 0 == s
           filterBank{ind} = filterBank{ind}'; 
        end
        ind = ind+1;
    end
    
    % Sobel horizontal edge-emphasizing filter
    for s = sobelSigma
        filterBank{ind} = getSobelFilter();
        if 0 == s
            filterBank{ind} = filterBank{ind}';
        end
        ind = ind+1;
    end
end

end

function h = getGaussianFilter(sigma)
    h = fspecial('gaussian',ceil(sigma*3*2+1),sigma);
end

function h = getLOGFilter(sigma)
    h = fspecial('log',ceil(sigma*3*2+1),sigma);
end

function hD = filterDerivativeX(h)
    ddx = [-1, 0, 1];
    hD = imfilter(h, ddx); 
end

function hD = filterDerivativeY(h)
    ddy = [-1, 0, 1]';
    hD = imfilter(h, ddy);
end

% Prewitt horizontal edge-emphasizing filter
function h = getPrewittFilter()
    h = fspecial('prewitt');
end

% Sobel horizontal edge-emphasizing filter
function h = getSobelFilter()
    h = fspecial('sobel');
end

