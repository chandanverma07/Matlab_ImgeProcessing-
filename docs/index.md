RGB Color Object Detection Using MATLAB

Basic Step for Detecting Red Color Object from Image:
1.	Read The RGB Image
2.	Extract Red Component from the Original Snapshot
3.	Subtract red-color Components from the grey 
4.	Image (new grey image)
5.	Remove the noise from the new grey image
6.	by using filter command.
7.	Convert the filtered image into binary image 
8.	(get bright image in place of the red object)
9.	Measure parameters of the bright image and place a rectangular box over it.

 




%Reading RGB Image
rgbimage=imread('Rgb_image2.png');
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
    
    

 
 
regionprops:
This is used to measure the image properties. 
stats regionprops(BW,properties)
stats = regionprops(BW,properties) returns measurements for the set of properties specified by properties for each 8-connected component (object) in the binary image.stats is struct array containing a struct for each object in the image. You can use regionprops on contiguous regions and discontiguous regions.
Calculate centroids for connected components in the image using regionprops.
s = regionprops(BW,'centroid')
bwareaopen:
Remove small objects from binary image
BW2 = bwareaopen(BW,P) removes all connected components (objects) that have fewer than P pixels from the binary image BW, producing another binary image, BW2. The default connectivity is 8 for two dimensions
bwlabel	
Label connected components in 2-D binary image
L = bwlabel(BW) returns the label matrix L that contains labels for the 8-connected objects found in BW. The label matrix, L, is the same size 
[L,num] = bwlabel(___) also returns num, the number of connected objects found in BW.
