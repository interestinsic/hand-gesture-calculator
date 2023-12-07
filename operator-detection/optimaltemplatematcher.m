clearvars;
imRGB=imread('capture.bmp');
BW = glovemask2(imRGB);
imRGB=imread('capture1.bmp');
template = glovemask2(imRGB);
biggestfactor = tempMatcher(BW,template);
function show(im,temp,x,y)
    minX = max(1,x);
    minY = max(1,y);
    maxX = min(size(im,1),x+size(temp,1));
    maxY = min(size(im,2),y+size(temp,2));
    imshow(im(minX:maxX,minY:maxY));
    
end
function corrFactor = tempMatcher(im, temp)
    
    topCorr = 0;
    x = 0;
    y = 0;
    
    % scan every 100 pixels of image first
    [x, y, topCorr] = search(0,50, x, y, im, temp, topCorr);
    
    % scan more precisely, based on highest correlation
    [x, y, topCorr] = search(8,1, x, y, im, temp, topCorr);
    %[x, y, topCorr] = search(50,25, x, y, im, temp, topCorr);
    %[x, y, topCorr] = search(25,5, x, y, im, temp, topCorr);
    %[x, y, topCorr] = search(0,1, x, y, im, temp, topCorr);
    
    
    subplot(3,4,5);
    imshow(temp);
    title('Plus sign template');

    corrFactor = topCorr / (size(temp,1) * size(temp,2));
    
    subplot(3,4,7);
    
    show(im,temp,x,y);
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

function [x, y, topCorr] = search(checkrange,checkstep, x, y, im, temp, topCorr)
    
    if(checkrange<=0)
        lowerX=max(1,x);
        lowerY=max(1,y);
        upperX=(size(im,1) - size(temp,1));
        upperY=(size(im,2) - size(temp,2));
    else
        lowerX = max((x - checkrange), 1);
        upperX = min((x + checkrange), (size(im,1) - size(temp,1)));

        lowerY = max((y - checkrange), 1);
        upperY = min((y + checkrange), (size(im,2) - size(temp,2)));
    end
    
    corr =topCorr;
    
    i =lowerX;
    j =lowerY;
    while(corr>=topCorr && i+checkstep<=upperX)
        topCorr =corr;
        i=i+checkstep;
        corr = calcCorr(im,temp,i,j);
        if corr<topCorr
            i=i-checkstep;
        end
    end
    
    while(corr>=topCorr && j+checkstep<=upperY)
        topCorr =corr;
        j=j+checkstep;
        corr = calcCorr(im,temp,i,j);
        if corr<topCorr
            j=j-checkstep;
        end
    end
    while(corr>=topCorr && i-checkstep>=lowerX)
        topCorr =corr;
        i=i-checkstep;
        corr = calcCorr(im,temp,i,j);
        if corr<topCorr
            i=i+checkstep;
        end
    end
    while(corr>=topCorr && j-checkstep>=lowerY)
        topCorr =corr;
        j=j-checkstep;
        corr = calcCorr(im,temp,i,j);
        if corr<topCorr
            j=j+checkstep;
        end
    end
    x=i;
    y=j;
end
