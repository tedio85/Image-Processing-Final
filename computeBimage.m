function [Bimage]=computeBimage(input) 
    Y = input;
    Y = im2double(Y);
    Y = im2uint8(Y);
    [m,n,p]=size(Y); 
    m1=fix(m/4); 
    n1=fix(n/4);
    m2=fix(3*m/4);
    n2=fix(3*m/4);

    A1=Y(1:m1,1:n,:); 
    A2=Y(m1+1:m2,1:n1,:); 
    A3=Y(m1+1:m2,n1:n2,:); 
    A4=Y(m1+1:m2,n2+1:n,:);
    A5=Y(m2+1:m,1:n,:);

    MA1=mean(A1(:));
    MA2=mean(A2(:));
    MA3=mean(A3(:));
    MA4=mean(A4(:));
    MA5=mean(A5(:));

    bimage =  ((MA1 + max(MA2, MA4))/2-(MA3 + MA5 + min(MA2, MA4))/3);
    if (bimage < 20)
        Bimage = 0;
    elseif(bimage>20 &&bimage <150 )
        Bimage = (bimage-20) /120;
    else
        Bimage = 1;
end

    