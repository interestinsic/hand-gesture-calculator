imRGB=imread('capture.bmp');
BW = glovemask2(imRGB);
imRGB=imread('capture1.bmp');
BW1 = glovemask2(imRGB);
imshow(BW1);
biggest =0.0;

posx=uint32(0);
posy=uint32(0);
for i =1:100:size(BW,1)-size(BW1,1)

for j =1:100:size(BW,2)-size(BW1,2) 
  
% Construct the correlation map
imshow(BW(i:i+size(BW1,1)-1,j:j+size(BW1,2)-1));


V =corr2(BW(i:i+size(BW1,1)-1,j:j+size(BW1,2)-1),BW1);

if V > biggest
    biggest =V;
    posx=i;
    posy=j;
    
end
 
end
end
maxx =size(BW,1)-size(BW1,1);
maxy =size(BW,2)-size(BW1,2);
checkrange =uint32(100);
boundsx1=uint32(posx+checkrange);
boundsx2=uint32(posx-checkrange);
boundsy1=uint32(posy+checkrange);
boundsy2=uint32(posy-checkrange);
if(boundsx1>maxx)
boundsx1=maxx;
end
if(boundsy1>maxy)
boundsy1=maxy;
end
if(boundsx2<=0)
boundsx2=1;
end
if(boundsy2<=0)
boundsy2=1;
end

for i =boundsx2:50:boundsx1

for j =boundsy2:50:boundsy1 
  
% Construct the correlation map
imshow(BW(i:i+size(BW1,1)-1,j:j+size(BW1,2)-1));


V =corr2(BW(i:i+size(BW1,1)-1,j:j+size(BW1,2)-1),BW1);

if V > biggest
    biggest =V;
    posx=i;
    posy=j;
    
end
 
end
end
maxx =size(BW,1)-size(BW1,1);
maxy =size(BW,2)-size(BW1,2);
checkrange =uint32(50);
boundsx1=uint32(posx+checkrange);
boundsx2=uint32(posx-checkrange);
boundsy1=uint32(posy+checkrange);
boundsy2=uint32(posy-checkrange);
if(boundsx1>maxx)
boundsx1=maxx;
end
if(boundsy1>maxy)
boundsy1=maxy;
end
if(boundsx2<=0)
boundsx2=1;
end
if(boundsy2<=0)
boundsy2=1;
end

for i =boundsx2:10:boundsx1

for j =boundsy2:10:boundsy1 
  
% Construct the correlation map
imshow(BW(i:i+size(BW1,1)-1,j:j+size(BW1,2)-1));


V =corr2(BW(i:i+size(BW1,1)-1,j:j+size(BW1,2)-1),BW1);

if V > biggest
    biggest =V;
    posx=i;
    posy=j;
    
end
 
end
end
maxx =size(BW,1)-size(BW1,1);
maxy =size(BW,2)-size(BW1,2);
checkrange =uint32(10);
boundsx1=uint32(posx+checkrange);
boundsx2=uint32(posx-checkrange);
boundsy1=uint32(posy+checkrange);
boundsy2=uint32(posy-checkrange);
if(boundsx1>maxx)
boundsx1=maxx;
end
if(boundsy1>maxy)
boundsy1=maxy;
end
if(boundsx2<=0)
boundsx2=1;
end
if(boundsy2<=0)
boundsy2=1;
end

for i =boundsx2:3:boundsx1

for j =boundsy2:3:boundsy1 
  
% Construct the correlation map
imshow(BW(i:i+size(BW1,1)-1,j:j+size(BW1,2)-1));


V =corr2(BW(i:i+size(BW1,1)-1,j:j+size(BW1,2)-1),BW1);

if V > biggest
    biggest =V;
    posx=i;
    posy=j;
    
end
 
end
end
maxx =size(BW,1)-size(BW1,1);
maxy =size(BW,2)-size(BW1,2);
checkrange =uint32(3);
boundsx1=uint32(posx+checkrange);
boundsx2=uint32(posx-checkrange);
boundsy1=uint32(posy+checkrange);
boundsy2=uint32(posy-checkrange);
if(boundsx1>maxx)
boundsx1=maxx;
end
if(boundsy1>maxy)
boundsy1=maxy;
end
if(boundsx2<=0)
boundsx2=1;
end
if(boundsy2<=0)
boundsy2=1;
end

for i =boundsx2:1:boundsx1

for j =boundsy2:1:boundsy1 
  
% Construct the correlation map
imshow(BW(i:i+size(BW1,1)-1,j:j+size(BW1,2)-1));


V =corr2(BW(i:i+size(BW1,1)-1,j:j+size(BW1,2)-1),BW1);

if V > biggest
    biggest =V;
    posx=i;
    posy=j;
    
end
 
end
end
