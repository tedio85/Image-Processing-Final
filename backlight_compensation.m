img = imread('testImg7.jpg');
imgYIQ = rgb2ntsc(img);
imgY = imgYIQ(:,:,1);

Bimage = computeBimage(imgY);
Bhist  = computeBhist(imgY);
Bf = computeBf(Bimage, Bhist);

[FLm, Hm] = findTurningPt(imgY, Bf);
compensated = compensationCurve(round(FLm), round(Hm), imgY);

imgYIQ(:,:,1) = compensated;
imgYIQ(:,:,1) = double(imgYIQ(:,:,1)) / 255;
result = ntsc2rgb(imgYIQ);
figure(1)
imshow(result);