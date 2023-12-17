% Function to find the highest correlation to the given operator template
function [topCorr, x, y] = tempMatcher(im, temp)

    topCorr = 0;
    x = 1;
    y = 1;

    % Return if the template is larger than the image
    if (size(im,1) < size(temp, 1)) || (size(im,2) < size(temp, 2))
        return
    end
    
    % scan every 10 pixels of image first
    for i = 1:10:size(im,1) - size(temp,1)
        for j = 1:10:size(im,2) - size(temp,2)
            emplaced = im(i:i+size(temp, 1) - 1, j:j+size(temp, 2) - 1);
            corr = dice(emplaced, temp);
            if corr > topCorr %finds highest corr and stores its position
                topCorr = corr;
                x = i;
                y = j;
            end
        end
    end
    
    % scan more precisely, based on highest correlation
    [x, y, topCorr] = search(5, x, y, im, temp, topCorr);
    [x, y, topCorr] = search(3, x, y, im, temp, topCorr);
    [x, y, topCorr] = search(1, x, y, im, temp, topCorr);
end

% A helper function to search for the best match within a specified range
function [x, y, topCorr] = search(checkrange, x, y, im, temp, topCorr)

    % Determine the search bounds ensuring they stay within the image
    lowerX = max((x - checkrange), 1);
    upperX = min((x + checkrange), (size(im,1) - size(temp,1)));

    lowerY = max((y - checkrange), 1);
    upperY = min((y + checkrange), (size(im,2) - size(temp,2)));

    % Scan the area around the best match found so far
    for i = lowerX:checkrange:upperX
        for j = lowerY:checkrange:upperY
            emplaced = im(i:i+size(temp, 1) - 1, j:j+size(temp, 2) - 1);
            corr = dice(emplaced, temp); %find current corr
            % Update the best correlation and its position if a better match is found
            if corr > topCorr
                topCorr = corr;
                x = i;
                y = j;
            end
        end
    end
end
