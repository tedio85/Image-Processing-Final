function [ Bhist ] = computeBhist( input )
    YIQ = rgb2ntsc(input);
    Y = YIQ(:,:,1);
    [M,N] = size(Y);
    [p, ] = imhist(Y);
    p = transpose(p);
    p = p / (M * N);
    T1 = 60;
    Y = im2uint8(Y);
    T2 = max( max(Y) ) - 61;
    sumPriority = sum(p(T1 : T2));
    if sumPriority < 0.01
        Bhist = 1;
    elseif sumPriority > 0.5
        Bhist = 0; 
    else
        Bhist = -2.0408 * sumPriority + 1.0204;
    end
end

