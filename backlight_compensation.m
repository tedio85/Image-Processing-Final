img = imread('testImg4.png');
imgYIQ = rgb2ntsc(img);
imgY = imgYIQ(:,:,1);

% Bimage = computeBimage(imgY);
% Bhist  = computeBhist(imgY);
% Bf = computeBf(Bimage, Bhist);

[FLm, Hm] = findTurningPt(imgY, 0.1831);
compensated = compensationCurve(round(FLm), round(Hm), imgY);

imgYIQ(:,:,1) = compensated;
imgYIQ(:,:,1) = double(imgYIQ(:,:,1)) / 255;
result = ntsc2rgb(imgYIQ);
figure(1)
imshow(result);