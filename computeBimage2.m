function [ Bimage ] = computeBimage2( I )
    hy = fspecial('sobel');
    hx = hy';
    Iy = imfilter(double(I), hy, 'replicate');
    Ix = imfilter(double(I), hx, 'replicate');
    gradmag = sqrt(Ix.^2 + Iy.^2);
%     figure(1)
%     imshow(gradmag,[]), title('Gradient magnitude (gradmag)')

    se = strel('disk', 20);
    Io = imopen(I, se);
%     figure(2)
%     imshow(Io), title('Opening (Io)')

    Ie = imerode(I, se);
    Iobr = imreconstruct(Ie, I);
%     figure(3)
%     imshow(Iobr), title('Opening-by-reconstruction (Iobr)')

    Ioc = imclose(Io, se);
%     figure(4)
%     imshow(Ioc), title('Opening-closing (Ioc)')

    Iobrd = imdilate(Iobr, se);
    Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
    Iobrcbr = imcomplement(Iobrcbr);
%     figure(5)
%     imshow(Iobrcbr), title('Opening-closing by reconstruction (Iobrcbr)')

    fgm = imregionalmax(Iobrcbr);
%     figure(6)
%     imshow(fgm), title('Regional maxima of opening-closing by reconstruction (fgm)')

    I2 = I;
    I2(fgm) = 255;
%     figure(7)
%     imshow(I2), title('Regional maxima superimposed on original image (I2)')

    se2 = strel(ones(5,5));
    fgm2 = imclose(fgm, se2);
    fgm3 = imerode(fgm2, se2);

    fgm4 = bwareaopen(fgm3, 20);
    I3 = I;
    I3(fgm4) = 255;
%     figure(8)
%     imshow(I3)
%     title('Modified regional maxima superimposed on original image (fgm4)')

    %bw = imbinarize(Iobrcbr);
    %level = graythresh(I);
    bw = im2bw(Iobrcbr, 0.3);
    figure(9)
    imshow(bw), title('Thresholded opening-closing by reconstruction (bw)')

    Y = I;
    Y = im2uint8(Y);
    Y = double(Y);
    bw = double(bw);
    [m,n,p]=size(Y); 
    
    bright = Y.*bw;
    sumBright = sum(sum(bright));
    dark = Y.*(~bw);
    sumDark = sum(sum(dark));
    brightP = sum(sum(bw));
    darkP = m * n - brightP;
    bimage = sumBright / brightP - sumDark / darkP;
        
    
    if (bimage < 20)
        Bimage = 0;
    elseif(bimage > 20 && bimage < 150 )
        Bimage = (bimage-20) /120;
    else
        Bimage = 1;
end

