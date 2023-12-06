function corrFactor = tempMatcher(im, temp)
    
    topCorr = 0;
    x = 0;
    y = 0;
    
    % scan every 100 pixels of image first
    for i = 1:10:size(im,1) - size(temp,1)
        for j = 1:20:size(im,2) - size(temp,2)
            corr = calcCorr(im,temp,i,j);
            if corr > topCorr
                topCorr = corr;
                x = i;
                y = j;
            end
        end
    end
    
    % scan more precisely, based on highest correlation
    [x, y, topCorr] = search(20, x, y, im, temp, topCorr);
    [x, y, topCorr] = search(15, x, y, im, temp, topCorr);
    [x, y, topCorr] = search(10, x, y, im, temp, topCorr);
    [x, y, topCorr] = search(5, x, y, im, temp, topCorr);
    [x, y, topCorr] = search(3, x, y, im, temp, topCorr);
    
    subplot(3,4,5);
    imshow(temp);
    title('Plus sign template');

    corrFactor = topCorr / (size(temp,1) * size(temp,2));
    
    subplot(3,4,7);
    imshow(im(x:x + size(temp,1),y:y + size(temp,2)));
    title(sprintf('Highest correlation on image: %d', corrFactor));
end

function corr = calcCorr(im,temp,x,y)

    corr = 0;
    for i = 1:1:size(temp,1)
        for j = 1:1:size(temp,2)
            if (im(x + i, y + j) == temp(i,j))
                corr = corr + 1;
            end
        end
    end
end

function [x, y, topCorr] = search(checkrange, x, y, im, temp, topCorr)

    lowerX = max((x - checkrange), 1);
    upperX = min((x + checkrange), (size(im,1) - size(temp,1)));

    lowerY = max((y - checkrange), 1);
    upperY = min((y + checkrange), (size(im,2) - size(temp,2)));
    
    for i = lowerX:checkrange:upperX
        for j = lowerY:checkrange:upperY
            corr = calcCorr(im,temp,i,j);
            if corr > topCorr
                topCorr = corr;
                x = i;
                y = j;
            end
        end
    end
end
