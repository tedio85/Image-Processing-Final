function [FLm, Hm] = findTurningPt(input, Bf)
    % The input should be the Y(luminance) of the image(grayscale)
    
    % size of input
    [M,N] = size(input);
    
    % Gaussian filter
    var = 4;
    filterSize = 6*var+1;
    smoothed = imgaussfilt(input, var,'FilterSize', [filterSize filterSize]);
    
    % generate histogram
    [pOri, ] = imhist(smoothed);
    pOri = transpose(pOri);
    pOri = pOri/(M*N);
    figure(1)
    plot(pOri);
    title('histogram')
    
    % remove the parts that are too high in histogram
    TH = 0.0013;
    p = pOri;
    for i=1:length(p)
        if(p(i) > TH)
            p(i) = TH;
        end
    end
    
    
    
    % find start/end pts of groups by flooding
    target = 99;    % target percentage of intensities under the threshold 
    range = 0.5;      % maximum percentage deviation of current and target
    
    % binary search 
    l = 0.000001;
    r = 0.5;
    while(1)
        m = (l+r)/2;
        curPercent = findPercent(m);
        
        if(abs(curPercent-target) <= range)
            break;
        else
            if(curPercent > target)
                r = m;
            else
                l = m;
            end
        end
        %fprintf('curPercent = %f, l = %f, m = %f,r = %f\n', curPercent, l, m, r);
    end
    fprintf('curPercent = %f, l = %f, m = %f,r = %f\n', curPercent, l, m, r);
    
    % get start/end points
    thresh = l;
    pairs = zeros(1, 10);
    j = 1;
    connected = 0;    % is walking inside a group
    count_MIN = 15;   % minimum size of a group
    count = 0;
    misCount_MAX = 2; % number of tolerated discontinuities
    misCount = 0;   
    for i=1:length(p)
        
        if(i == length(p) && connected == 1) %reaches end of histogram
            if(count >= count_MIN)
                pairs(j) = start;
                pairs(j+1) = i;
                j = j+2;
                connected = 0;
                count = 0;
            end
        end
        
        if(p(i) > thresh)
            if(connected == 0)
                start = i;
                connected = 1;
            else
                misCount = 0;
            end
            count = count + 1;
        else
            if(connected == 1)
                if(misCount < misCount_MAX)
                    misCount = misCount+1;
                else
                    if(count >= count_MIN)
                        pairs(j) = start;
                        pairs(j+1) = i;
                        j = j+2;
                        connected = 0;
                        count = 0;
                    end
                end
            end
        end
    end
    figure(2)
    plot(p);
    title('histogram & threshold')
    ref = refline(0, thresh)
    ref.Color = 'r';
    thresh
    pairs
    p
    % FLm, Lm, Hm
%     tmp = (1:1:256);
%     Lm = sum(p(T(1):T(2)).*tmp(T(1):T(2))) / sum(p(T(1):T(2)));
%     if(isnan(Lm))
%         Lm = sum(p(T(1):T(2)).*tmp(T(1):T(2)));
%     end
%     
%     Hm = sum(p(T(3):T(4)).*tmp(T(3):T(4))) / sum(p(T(3):T(4)));
%     if(isnan(Hm))
%         Hm = sum(p(T(3):T(4)).*tmp(T(3):T(4)));
%     end
%     
%     FLm = Lm + Lm * Bf;
    
    % find percentage under the designated threshold
    function per = findPercent(thresh)
        per = 0;
        total = sum(p);
        for z=1:length(p)
            if(p(z)<= thresh)
                per = per + p(z)/total;
            else
                per = per + thresh/total;
            end
        end
        per = per * 100;
    end
    
end

