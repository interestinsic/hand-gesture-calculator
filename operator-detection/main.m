templates = ["plusBW.bmp", "minusBW.bmp", "multiplyBW.bmp", "devideBW.bmp"];
operands = ["Plus", "Minus", "Multiplication", "Devision"];

plusTemp = imread(templates(1));
minusTemp = imread(templates(2));
multiplyTemp = imread(templates(3));
devideTemp = imread(templates(4));
fingerTemp = imread("fingerBW.bmp");

vid = videoinput('winvideo',1);
set(vid,'ReturnedColorSpace','rgb');
start(vid);
preview(vid);

while true

    pause(3);
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
    im = imopen(im, strel('disk', 4));
    [r,c] = find(im);

    if (size(r, 1) == 0) || (size(c, 1) == 0)
        disp("nothing detected, end of sequence\n");
        break;
    end

    r1 = max(1, min(r) - 100);
    r2 = min(size(im,1), max(r) + 100);
    c1 = max(1, min(c) - 100);
    c2 = min(size(im,2), max(c) + 100);
    im = im(r1:r2,c1:c2);
    subplot(3,4,3);
    imshow(im);
    title('Clean and cropped');

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
    imcropped = im(x:min(size(im,1), x + size(temp,1)),y:min(size(im,2), y + size(temp,2)));
    subplot(3,4,7);
    imshow(imcropped);
    title(sprintf('Highest correlation on image: %d', corr));

    if corr > 0.9
        fprintf('%s sign, corr: %d\n', operands(i), corr);
    else
        numFingers = countFingers(im, fingerTemp);
        fprintf('%d fingers\n', numFingers);
    end
end

stop(vid);
delete(vid);
