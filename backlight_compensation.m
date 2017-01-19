img = imread('./testImg/testImg.tif');

imgYIQ = rgb2ntsc(img);
imgYIQ2 = imgYIQ;

% imgY: the luminance of the original image
imgY = imgYIQ(:,:,1);

% Bimage: method proposed by the research paper
% Bimage2: our method: try to single out the darker parts
Bimage = computeBimage(imgY);
Bimage2 = computeBimage2(imgY);
Bhist  = computeBhist(imgY);
Bf = computeBf(Bimage, Bhist);
Bf2 = computeBf(Bimage2, Bhist);

% compensated: find compensation curve using Bimage
% compensated2: find compensation curve using Bimage2
[FLm, Hm] = findTurningPt(imgY, Bf);
[FLm2, Hm2] = findTurningPt(imgY, Bf2);
compensated = compensationCurve(round(FLm), round(Hm), imgY);
compensated2 = compensationCurve(round(FLm2), round(Hm2), imgY);

imgYIQ(:,:,1) = compensated;
imgYIQ(:,:,1) = double(imgYIQ(:,:,1)) / 255;
result = ntsc2rgb(imgYIQ);
figure(1)
imshow(img), title('Original Image');

figure(2)
imshow(result), title('Method proposed by the research paper');


imgYIQ2(:,:,1) = compensated2;
imgYIQ2(:,:,1) = double(imgYIQ2(:,:,1)) / 255;
result2 = ntsc2rgb(imgYIQ2);
figure(3)
imshow(result2), title('Method by our team');

