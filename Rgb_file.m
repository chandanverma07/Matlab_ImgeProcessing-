%Reading RGB Image
rgbimage=imread('Rgb_Image.png');
%Converting RGB Image Into Gray 
grayimage=rgb2gray(rgbimage);
%Extracting Red Componet from rgbimage
red_image=rgbimage(:,:,1);
% Substracting grayimage from red_image
substract_image=red_image-grayimage;
%Filter out (Remove Noise) from substract_image
filter_image=medfilt2(substract_image,[3,3]);
%Converting flter_image into Binary Image for Morphological operation 
binary_image=imbinarize(filter_image,.18);
%ploting all the image
subplot(2,3,1)
imshow(rgbimage)
title("RGB Image")
subplot(2,3,2)
imshow(grayimage)
title("Gray Image")
subplot(2,3,3)
imshow(red_image)
title("Red Image")
subplot(2,3,4)
imshow(substract_image)
title("Substracted_Image")
subplot(2,3,5)
imshow(filter_image)
title("Filtered Image")
subplot(2,3,6)
imshow(binary_image);
title("Binary_image")
image_morph=bwareaopen(binary_image,300);
n,image_bw=bwlabel(image_morph,8);
stats=regionprops(image_bw,'BoundingBox','Centroid');
figure
imshow(rgbimage)
hold on
for obj=1:length(stats)
    bbox=stats(obj).BoundingBox;
    bcentroid=stats(obj).Centroid;
    rectangle('Position',bbox,'EdgeColor','r','LineWidth',2)
    plot(bcentroid(1),bcentroid(2),'-m+')
    a=text(bcentroid(1)+15,bcentroid(2)+15,strcat('X: ',num2str(round(bcentroid(1))),'Y: ',num2str(round(bcentroid(2)))));
    set(a,'FontName','Arial','FontWeight','bold','FontSize',12,'Color','black');
end 
hold off
    
    
 





