plusTemp = imread("plusBW.bmp");
fingerTemp = imread("template3.bmp");

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
    subplot(3,4,3);
    imshow(im);
    title('Filled holes');

    corr = tempMatcher(im, plusTemp);
    if corr > 0.8
        fprintf('plus sign, corr: %d\n', corr);
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
