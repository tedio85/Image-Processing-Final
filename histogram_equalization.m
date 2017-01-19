img = imread('./testImg/testImg.tif');
imgYIQ = rgb2ntsc(img);
imgYIQ(:,:,1) = histeq(imgYIQ(:,:,1));
result = ntsc2rgb(imgYIQ);
figure(1)
title('histogram equalization');
imshow(result);
figure(2)
imhist(imgYIQ(:,:,1));
title('histogram');
