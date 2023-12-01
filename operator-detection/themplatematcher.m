imRGB=imread('capture.bmp');
BW = glovemask2(imRGB);
imRGB=imread('capture1.bmp');
BW1 = glovemask2(imRGB);
imshow(BW1);
biggest =0.0;
disp(size(BW,1));
disp(size(BW,2));
disp(size(BW1,1));
disp(size(BW1,2));
for i = 1:size(BW,1)-size(BW1,1) 
disp("test2");
for j = 1:size(BW,2)-size(BW1,2) 
  
% Construct the correlation map
imshow(BW(i:i+size(BW1,1)-1,j:j+size(BW1,2)-1));


V =corr2(BW(i:i+size(BW1,1)-1,j:j+size(BW1,2)-1),BW1);
disp(V);
if V > biggest
    biggest =V;
    disp("updated");
end
 
end
end

