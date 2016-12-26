img = imread('./testImg/testImg9.jpg');

imgYIQ = rgb2ntsc(img);
imgY = imgYIQ(:,:,1);

Bimage = computeBimage(imgY);
Bhist  = computeBhist(imgY);
Bf = computeBf(Bimage, Bhist);

[FLm, Hm] = findTurningPt(imgY, Bf);
compensated = compensationCurve(round(FLm), round(Hm-60), imgY);

imgYIQ(:,:,1) = compensated;
imgYIQ(:,:,1) = double(imgYIQ(:,:,1)) / 255;
result = ntsc2rgb(imgYIQ);
figure(1)
imshow(img);
figure(3)
imshow(result);