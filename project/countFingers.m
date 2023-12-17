function numFingers = countFingers(im, temp)

subplot(3,4,9);
imshow(temp);
title('Finger template');

% Morphological opening on the image using the finger template
im2 = imopen(im,strel(temp));
im = im - im2;
% Subtracting the opened image from the original to enhance finger regions
subplot(3,4,10);
imshow(im);
title('Template applied');

% Remove small objects or noise not removed in the previous step
im = imopen(im, strel('disk',16));
subplot(3,4,11);
imshow(im);
title('Noise removed');

% Labeling connected components (potential fingers) in the image
[labels,numlabels] = bwlabel(im);
im = label2rgb(labels);
subplot(3,4,12);
imshow(im);
title('Fingers counted');

numFingers = numlabels;
