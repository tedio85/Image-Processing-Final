function [ Bimage ] = computeBimage2( I )
    se = strel('disk', 20);
    Ie = imerode(I, se);
    Iobr = imreconstruct(Ie, I);
%     figure(6)
%     imshow(Iobr), title('Opening-by-reconstruction (Iobr)')

    Iobrd = imdilate(Iobr, se);
    Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
    Iobrcbr = imcomplement(Iobrcbr);
%     figure(7)
%     imshow(Iobrcbr), title('Opening-closing by reconstruction (Iobrcbr)')

    bw = im2bw(Iobrcbr, 0.3);
    figure(5)
    imshow(bw), title('Seperate bright and dark part of the image')

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
        Bimage = (bimage-20) /130;
    else
        Bimage = 1;
end

