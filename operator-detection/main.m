templates = ["plusBW.bmp", "minusBW.bmp", "multiplyBW.bmp", "devideBW.bmp"];
plusTemp = imread(templates(1));
minusTemp = imread(templates(2));
multiplyTemp = imread(templates(3));
devideTemp = imread(templates(4));

fingerTemp = imread("template3.bmp");

operands = ["Plus", "Minus", "Multiplication", "Devision"];

vid = videoinput('winvideo',1);
set(vid,'ReturnedColorSpace','rgb');
start(vid);
preview(vid);

while true

    pause(5);
    im = getsnapshot(vid);

    imwrite(im,'tempcapture.bmp','bmp');
    im = imread('tempcapture.bmp');

    subplot(3,4,1);
    imshow(im);
    title('RGB image');
    
    im = gloveMask3(im);
    subplot(3,4,2);
    imshow(im);
    title('BW image');
    
    im = imfill(im, 8, "holes");
    subplot(3,4,3);
    imshow(im);
    title('Filled holes');

    [plusCorr, x1, y1] = tempMatcher(im, plusTemp);
    [minusCorr, x2, y2] = tempMatcher(im, minusTemp);
    [multiplyCorr, x3, y3] = tempMatcher(im, multiplyTemp);
    [devideCorr, x4, y4] = tempMatcher(im, devideTemp);

    corrs = [plusCorr, minusCorr, multiplyCorr, devideCorr];
    [corr, i] = max(corrs);

    xs = [x1, x2, x3, x4];
    ys = [y1, y2, y3, y4];

    temp = imread(templates(i));
    subplot(3,4,5);
    imshow(temp);
    title(sprintf('%s sign template', operands(i)));

    x = xs(i);
    y = ys(i);
    imcropped = im(x:x + size(temp,1),y:y + size(temp,2));
    subplot(3,4,7);
    imshow(imcropped);
    title(sprintf('Highest correlation on image: %d', corrFactor));

    if corr > 0.8
        fprintf('%s sign, corr: %d\n', operands(i), corr);
    else
        numFingers = countFingers(im, fingerTemp);
        if numFingers > 0
            fprintf('%d fingers\n', numFingers);
        else
            disp("nothing detected, end of sequence\n");
            break;
        end
    end
end

stop(vid);
delete(vid);
