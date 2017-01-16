function output = watershed_segmentation(input)

[gradient, ] = imgradient(input);
maximum = max(max(gradient));
minimum = min(min(gradient));


end

