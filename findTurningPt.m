function [FLm, Hm] = findTurningPt(input, Bf)
    % The input should be the Y(luminance) of the image(grayscale)
    
    % size of input
    [M,N] = size(input);
    
    % Gaussian filter
    var = 4;
    filterSize = 6*var+1;
    smoothed = imgaussfilt(input, var,'FilterSize', [filterSize filterSize]);
    
    % generate histogram
    [p, ] = imhist(smoothed);
    p = transpose(p);
    p = p/(M*N);
    figure(1)
    plot(p);
    title('histogram')
    
    % generate series a,b
    TH = 0.0013;
    a = zeros(1, 256);
    b = zeros(1, 255);
    
    for i=1:256
        if(p(i)<=TH)
            a(i) = i;
        end
    end
    figure(2)
    plot(a)
    title('a');
    
    for i=2:256
        b(i-1) = abs(a(i) - a(i-1));
    end
    figure(3)
    plot(b)
    title('b');
    
    % obtain set T
    count=1;
    T = zeros(1, 10);
    for i=1:255
        for j=1:256
            if(b(i)==a(j) && b(i)~=0)
                T(count) = j;
                count = count+1;
            end
            if(b(i) == a(i+1) && b(i)~=0)
                T(count) = i+1;
                count = count+1;
            end
        end
    end
    figure(4)
    plot(T)
    title('T');
    
    % FLm, Lm, Hm
    tmp = (1:1:256);
    Lm = sum(p(T(1):T(2)).*tmp(T(1):T(2))) / sum(p(T(1):T(2)));
    Hm = sum(p(T(3):T(4)).*tmp(T(3):T(4))) / sum(p(T(3):T(4)));
    FLm = Lm + Lm * Bf;
    
end

