img = imread('./testImg/testImg9.jpg');
[M,N] = size(img);
imgYIQ = rgb2ntsc(img);
[a,b] = imhist(imgYIQ(:,:,1));
a = a/(M*N);
figure(1);
plot(a);
title('original image');

img = imread('./testImg/testImg9_result.jpg');
[M,N] = size(img);
imgYIQ = rgb2ntsc(img);
[a,b] = imhist(imgYIQ(:,:,1));
a = a/(M*N);
figure(2);
plot(a);
title('our method');

img = imread('./testImg/testImg9_histeq.tif');
[M,N] = size(img);
imgYIQ = rgb2ntsc(img);
[a,b] = imhist(imgYIQ(:,:,1));
a = a/(M*N);
figure(3);
plot(a);
title('histogram equalization');