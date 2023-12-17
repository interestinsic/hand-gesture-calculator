% Load templates for arithmetic operations and fingers
templates = ["plusBW.bmp", "minusBW.bmp", "multiplyBW.bmp", "devideBW.bmp"];
operands = ["+", "-", "*", "/"];

% Read each template image from the file
plusTemp = imread(templates(1));
minusTemp = imread(templates(2));
multiplyTemp = imread(templates(3));
devideTemp = imread(templates(4));
fingerTemp = imread("fingerBW.bmp");

expression = "";
valid = true;

% Set up the video input from the webcam
vid = videoinput('winvideo',1);
set(vid,'ReturnedColorSpace','rgb');
start(vid);
preview(vid);

% Loop to continuously capture images
while true

    for i = 3:-1:1
        % Countdown for next picture capture
        fprintf('Next picture in:  %d\n', i);
        pause(1);
    end

    im = getsnapshot(vid);

    % Store image locally
    imwrite(im,'tempcapture.bmp','bmp');
    im = imread('tempcapture.bmp');

    % Display the original RGB image
    subplot(3,4,1);
    imshow(im);
    title('RGB image');

    % Apply the glove color thresholding function and get a Binary image in return
    im = gloveMask(im);
    subplot(3,4,2);
    imshow(im);
    title('BW image');

    % Fill holes and remove noise from the binary image
    im = imfill(im, 8, "holes");
    im = imopen(im, strel('disk', 4));
    [r,c] = find(im);

    % Check if there are any detected objects, otherwise end the loop
    if (size(r, 1) == 0) || (size(c, 1) == 0)
        disp("Nothing detected, end of sequence");
        break;
    end

    % Crop the image to the region of interest
    r1 = max(1, min(r) - 100);
    r2 = min(size(im,1), max(r) + 100);
    c1 = max(1, min(c) - 100);
    c2 = min(size(im,2), max(c) + 100);
    im = im(r1:r2,c1:c2);
    subplot(3,4,3);
    imshow(im);
    title('Clean and cropped');

    % Use template matching to find correlation with each operator
    [plusCorr, x1, y1] = tempMatcher(im, plusTemp);
    [minusCorr, x2, y2] = tempMatcher(im, minusTemp);
    [multiplyCorr, x3, y3] = tempMatcher(im, multiplyTemp);
    [devideCorr, x4, y4] = tempMatcher(im, devideTemp);

    % Find the highest correlation of all operator templates
    corrs = [plusCorr, minusCorr, multiplyCorr, devideCorr];
    [corr, i] = max(corrs);

    xs = [x1, x2, x3, x4];
    ys = [y1, y2, y3, y4];

    % Load and display the template with the highest correlation
    temp = imread(templates(i));
    subplot(3,4,5);
    imshow(temp);
    title(sprintf('Highest correlation template: %s', operands(i)));

    % Crop the image around the region of the highest correlation
    x = xs(i);
    y = ys(i);
    imcropped = im(x:min(size(im,1), x + size(temp,1)),y:min(size(im,2), y + size(temp,2)));
    subplot(3,4,7);
    imshow(imcropped);
    title(sprintf('Highest correlation on image: %.1f%%', corr * 100));

    %check if corr is above a threshold 
    if corr > 0.88
        %detect an operation
        fprintf('Operator: %s\n', operands(i));
        c = char(expression);
        %get vadility of expression
        if (size(c) == 0)
            valid = false;
        elseif ~(isstrprop(c(end),'digit'))
            valid = false;
        end
        expression = strcat(expression, operands(i));
        delete(subplot(3,4,9:12));
    else
        % Detect the number of fingers and add it to the expression
        numFingers = countFingers(im, fingerTemp);
        if numFingers > 0
            fprintf('Number: %d\n', numFingers);
            expression = strcat(expression, int2str(numFingers));
        else
            disp("Nothing detected, end of sequence");
            break;
        end
    end

    % Display the current arithmetic expression
    fprintf('Current sequence: %s\n\n', expression);
end

% Stop and delete the video input
stop(vid);
delete(vid);

% Display the final result
disp("Result:");
c = char(expression);
if (size(c) == 0)
    valid = false;
elseif ~(isstrprop(c(end),'digit'))
    valid = false;
end

% Check if expression is valid, display an error message if it's not
if valid
    disp(eval(expression));
else
    disp("Invalid expression")
end
