function numFingers = countFingers(im, temp)

subplot(3,4,9);
imshow(temp);
title('Finger template');

im2 = imopen(im,strel(temp));
im = im - im2;
subplot(3,4,10);
imshow(im);
title('Template applied');

im = imopen(im, strel('disk',16));
subplot(3,4,11);
imshow(im);
title('Noise removed');

[labels,numlabels] = bwlabel(im);
im = label2rgb(labels);
subplot(3,4,12);
imshow(im);
title('Fingers counted');

numFingers = numlabels;
