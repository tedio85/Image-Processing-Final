img = imread('./testImg/testImg5.jpg');

imgYIQ = rgb2ntsc(img);
imgY = imgYIQ(:,:,1);

Bimage2 = computeBimage2(imgY);
Bimage = computeBimage(imgY);
Bhist  = computeBhist(imgY);
Bf2 = computeBf(Bimage2, Bhist);
Bf = computeBf(Bimage, Bhist);

Bf
Bf2

[FLm2, Hm2] = findTurningPt(imgY, Bf2);
[FLm, Hm] = findTurningPt(imgY, Bf);
compensated2 = compensationCurve(round(FLm2), round(Hm2), imgY);
compensated = compensationCurve(round(FLm), round(Hm), imgY);

imgYIQ(:,:,1) = compensated;
imgYIQ(:,:,1) = double(imgYIQ(:,:,1)) / 255;
result = ntsc2rgb(imgYIQ);
figure(1)
imshow(img);
figure(3)
imshow(result);

imgYIQ(:,:,1) = compensated2;
imgYIQ(:,:,1) = double(imgYIQ(:,:,1)) / 255;
result = ntsc2rgb(imgYIQ);
figure(7)
imshow(result);