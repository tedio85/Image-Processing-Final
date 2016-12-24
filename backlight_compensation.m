img = imread('testImg.tif');
imgYIQ = rgb2ntsc(img);
imgY = imgYIQ(:,:,1);

Bimage = computeBimage(imgY);
Bhist  = computeBhist(imgY);
Bf = computeBf(Bimage, Bhist);

[FLm, Hm] = findTurningPt(imgY, Bf);
compensated = compensationCurve(round(FLm), round(Hm), imgY);

imgYIQ(:,:,1) = im2single(compensated);
result = ntsc2rgb(imgYIQ);