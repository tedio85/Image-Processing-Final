function [FLm, Hm] = findTurningPt(input, Bf)
    % The input should be the Y(luminance) of the image(grayscale)
    
    % size of input
    [M,N] = size(input);
    
    % Gaussian filter
    var = 4;
    filterSize = 6*var+1;
    %smoothed = imgaussfilt(input, var,'FilterSize', [filterSize filterSize]);
    gauss = fspecial('gaussian',[filterSize, filterSize], sqrt(var));
    smoothed = conv2(input, gauss);
    
    % generate histogram
    [p, ] = imhist(smoothed);
    p = transpose(p);
    p = p/(M*N);
%     figure(1)
%     plot(p);
%     title('histogram')  
        
    % find start/end pts of groups by flooding
    thresh = 0.0001;
    groupSize_MIN = 20;
    dist = 20;  % is close enough to merge with prev/next group
    interSpacing_MIN = 20;
    ok = 0;
    marked2remove = -100;
    while(ok==0)
        
        [s,e] = getPairs(thresh);
        while(length(s) > 6)
            thresh = thresh + 0.0001;
            [s,e] = getPairs(thresh);
        end
        
        % group size limiting
        for i=1:length(s)
            if(e(i)-s(i) < groupSize_MIN) 
                if( i>1 && e(i-1)~=0 && s(i)-e(i-1) < dist )  %previous group
                    s(i) = s(i-1);
                    s(i-1) = marked2remove;
                    e(i-1) = marked2remove;                
                elseif( i<length(s) && s(i+1)-e(i) < dist )      %next group
                    s(i+1)=s(i);
                    s(i) = marked2remove;
                    e(i) = marked2remove;
                else                            %delete this group
                    s(i) = marked2remove;
                    e(i) = marked2remove;
                end
            end
        end
        s = s(s~=marked2remove);
        e = e(e~=marked2remove);
        
        % inter group spacing
        for j=2:length(s)
            if(s(j) - e(j-1) < interSpacing_MIN)
                s(j) = s(j-1);
                e(j-1) = marked2remove;
                s(j-1) = marked2remove;
            end
        end
        s = s(s~=marked2remove);
        e = e(e~=marked2remove);
        
        
        % 2 <= # of groups <= 3
        if(length(s)>=2 && length(s)<=3)
            ok = 1;
        else
            thresh = thresh + 0.0001;
        end
    end
%     s
%     e
%     
%     figure(2)
%     plot(p);
%     title('histogram & threshold')
%     ref = refline(0, thresh);
%     ref.Color = 'r';
%     thresh
    
    % FLm, Lm, Hm
    tmp = (1:1:256);
    Lm = sum(p(s(1):e(1)).*tmp(s(1):e(1))) / sum(p(s(1):e(1)));
    if(isnan(Lm))
        Lm = sum(p(s(1):e(1)).*tmp(s(1):e(1)));
    end
    
    Hm = sum(p(s(2):e(2)).*tmp(s(2):e(2))) / sum(p(s(2):e(2)));
    if(isnan(Hm))
        Hm = sum(p(s(2):e(2)).*tmp(s(2):e(2)));
    end
    
    FLm = Lm + Lm * Bf;
    
    
    % find pairs of start/end points
    % count_MIN - minimum size of a group
    % misCount_MAX - number of tolerated discontinuities
    function [s, e] = getPairs(thresh)
        s = zeros(1,256);
        e = zeros(1,256);
        connected = 0;
        count = 1;
        for i=1:length(p)
            
            if(p(i)>thresh)
                if(connected == 0)
                    s(count) = i;
                    connected = 1;
                end
            else
                if(connected == 1)
                    e(count) = i;
                    connected = 0;
                    count = count+1;
                end
            end
            
            if(i==length(p) && connected == 1)  % is at the end
                e(count) = i;
                count = count+1;
            end
        end
        s = s(s~=0);
        e = e(e~=0);
    end


end

