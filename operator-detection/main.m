clearvars;
vid=videoinput('winvideo',1);
set(vid,'ReturnedColorSpace','rgb');
start(vid);
preview(vid);

pause(1);

imRGB=getsnapshot(vid);
imRGB=imread('capture.bmp');
imread('capture.bmp');
stop(vid);
delete(vid);

imwrite(imRGB,'capture.bmp','bmp');

subplot(3,3,1)
imshow(imRGB)

[BW,maskedRGBImage] = gloveMask(imRGB);
subplot(3,3,2);
imshow(BW);

BW = imfill(BW,"holes");
BW=imopen(BW,strel('square',10));
subplot(3,3,3);
imshow(BW);

BWH = imopen(BW,strel('disk',80));
subplot(3,3,4);
imshow(BWH);

BWF = BW - BWH;
BWF=imopen(BWF,strel('disk',17));
subplot(3,3,5);
imshow(BWF);


[labels,numlabels]=bwlabel(BWF);
BWF=label2rgb(labels);
subplot(3,3,6);
imshow(BWF);


stats = regionprops(labels, 'all');
