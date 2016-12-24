function [ Bhist ] = computeBhist( input )
    G = rgb2gray(input);
    YIQ = rgb2ntsc(input);
    I = YIQ(:,:,1);
    [M,N] = size(I);
    [p, ] = imhist(I);
    p = transpose(p);
    p = p / (M * N);
    T1 = 60;
    T2 = max( max(G) ) - 61;
    sumPriority = sum(p(T1 : T2));
    Bhist = -2.0408 * sumPriority + 1.0204;
    if sumPriority < 0.01
        Bhist = 1;
    if sumPriority > 0.5
        Bhist = 0; 
    end
end

