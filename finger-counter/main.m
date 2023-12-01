vid = videoinput('winvideo',1);
set(vid,'ReturnedColorSpace','rgb');
start(vid);
% preview(vid);
 
pause(1);

im = getsnapshot(vid);
stop(vid);
delete(vid);

% imwrite(imRGB,'capture.bmp','bmp');
% imRGB = imread('capture.bmp');

subplot(3,3,1)
imshow(im)

[im,maskedRGBImage] = gloveMask(im);
subplot(3,3,2);
imshow(im);

im = imfill(im, 8, "holes");
subplot(3,3,3);
imshow(im);

im2 = imopen(im,strel(template3));
subplot(3,3,4);
imshow(im2);

im = im - im2;
subplot(3,3,5);
imshow(im);

im = imopen(im, strel('disk', 16));
subplot(3,3,6);
imshow(im);

[labels,numlabels] = bwlabel(im);
im = label2rgb(labels);
subplot(3,3,7);
imshow(im);

disp(['Fingers: ',num2str(numlabels)]);
