function output = localThresholding(input, mSize, a, b)
    
    inputSize = size(input);
    output = zeros(inputSize(1),inputSize(2));
    maskSize = zeros(1,2);
    
    input = im2uint8(input);
    
    % maskX/maskY is not odd, pad zeros to make the mask width/height odd
    for i=1:2
        if(mod(mSize(i),2)==0)
            maskSize(i) = mSize(i)+1;
        else
            maskSize(i) = mSize(i);
        end
    end
    
    % peform local thresholding
    f = padarray(input, (maskSize-1)/2, 'symmetric');
    [M,N] = size(f);
    x = (maskSize(1)-1)/2;
    y = (maskSize(1)-1)/2;
    
    for i=x+1:M-x
        for j=y+1:N-y
            submat = double(im2uint8(f(i-x:1:i+x, j-y:1:j+y)));
            mean = sum(sum(submat))/(maskSize(1)*maskSize(2));
            meanFSquare = sum(sum(submat.^2))/(maskSize(1)*maskSize(2));
            dev = sqrt(meanFSquare - mean^2);   %standard deviation
            
            if(f(i,j) > a*dev && f(i,j) > b*mean)
                output(i-x,j-y) = 1;
            else
                output(i-x,j-y) = 0;
            end
        end
    end

    output = single(output);
end

