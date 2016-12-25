img = imread('./testImg/testImg8.jpg');
imgYIQ = rgb2ntsc(img);
imgYIQ(:,:,1) = histeq(imgYIQ(:,:,1));
result = ntsc2rgb(imgYIQ);
figure(1)
imshow(result);