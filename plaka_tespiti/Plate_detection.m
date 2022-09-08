close all;
clear all;
im = imread('klas�rdekiaracgoruntusu.jpg');
figure
imshow(im), title("\color{red}Orijinal Resim")
imgray = rgb2gray(im);
figure
imshow(imgray), title("\color{red}Gri Seviyeye D�n��t�rme ��lemi")
imbin = imbinarize(imgray);
figure
imshow(imbin) , title("\color{red}Binary Seviyeye D�n��t�rme ��lemi")
imgraynew = medfilt2(imgray);
figure
imshow(imgraynew) , title("\color{red}Medyan Filtre ��lemi")
im = edge(imgraynew, 'sobel');
figure
imshow(im) , title("\color{red}Sobel Filtresi ��lemi")
im=imdilate(im,strel('diamond',2));
figure
imshow(im) , title("\color{red} Kenarlar� Geni�letme ��lemi")
im2=imfill(im,'holes');
figure
imshow(im2) , title("\color{red}Dikd�rtgen Alanlar� Doldurma ��lemi")
im=imopen(im,strel('rectangle',[2 2]));

Iprops=regionprops(im,'BoundingBox','Area', 'Image');
area = Iprops.Area;
count = numel(Iprops);
maxa= area;
boundingBox = Iprops.BoundingBox;
for i=1:count
   if maxa<Iprops(i).Area
       maxa=Iprops(i).Area;
       boundingBox=Iprops(i).BoundingBox;
   end
end    

im = imcrop(imbin, boundingBox);
figure
imshow(im) , title("\color{red}Plakan�n Yerini Tespit Etme ��lemi")
im = bwareaopen(~im, 500); 
figure
imshow(im) , 

 [h, w] = size(im);%get width


Iprops=regionprops(im,'BoundingBox','Area', 'Image'); %read letter
count = numel(Iprops);
noPlate=[]; % Initializing the variable of number plate string.

for i=1:count
   ow = length(Iprops(i).Image(1,:));
   oh = length(Iprops(i).Image(:,1));
   if ow<(h/2) & oh>(h/3)
       letter=Letter_detection(Iprops(i).Image); % Reading the letter corresponding the binary image 'N'.
       noPlate=[noPlate letter] % Appending every subsequent character in noPlate variable.
   end
end