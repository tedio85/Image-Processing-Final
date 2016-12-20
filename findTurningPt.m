function [FLm, Hm] = findTurningPt(input)
    % The input should be the Y(luminance) of the image(grayscale)

    % Gaussian filter
    var = 4;
    filterSize = 6*var+1;
    smoothed = imgaussfilt(input, var,'FilterSize', [filterSize filterSize]);
    
    % generate histogram
    
    
end

