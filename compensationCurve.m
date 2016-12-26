function [ output ] = compensationCurve( a, b, input )
    [M, N] = size(input);
    input = im2uint8(input);
    curve = zeros(1, 255);
    output = zeros(M, N);
    for i = 1 : a
        curve(i) = (-b / a^2 ) * (i - a)^2 + b;
    end
    for i = a+1 : 255
        curve(i) = ( (255 - b) / (255 - a)^2 ) * (i - a)^2 + b;
    end
    for i = 1 : M
        for j = 1: N
            if(input(i, j) == 0)
                output(i, j) = curve(1);
%             elseif(input(i,j)<200)
            else
                output(i, j) = curve( input(i, j) );
%             else
%                 output(i,j) = input(i,j);
            end
        end
    end
    figure(4)
    plot(curve)
    title('compensation curve')
end

