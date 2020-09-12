clc;
clear all;
close all;

filesRGB = dir('/Users/mauroloddo/Documents/MATLAB/SeedClasification/Canadians families/Amaranthaceae2/*.jpg'); %totale delle immagini da analizzare
N = length(filesRGB); %Numero immagini
pathRGB = '/Users/mauroloddo/Documents/MATLAB/SeedClasification/Canadians families/Amaranthaceae2/'; %path cartella

filesBinary = dir('/Users/mauroloddo/Documents/MATLAB/SeedClasification/GT Canadians families/GTAmaranthaceae3/*.jpg'); %totale delle immagini da analizzare
pathBinary = '/Users/mauroloddo/Documents/MATLAB/SeedClasification/GT Canadians families/GTAmaranthaceae3/'; %path cartella

%for l = 1:N
l=1;
imageNameRGB = filesRGB(l).name;          %nome dell'immagine
stringRGB = strcat(pathRGB, imageNameRGB);   %path completo dell'immagine
RGB = imread(stringRGB);                 %immagine da analizzare

imageNameBinary = filesBinary(l).name;          %nome dell'immagine
stringBinary = strcat(pathBinary, imageNameBinary);   %path completo dell'immagine
mask = imread(stringBinary);                 %immagine da analizzare
mask2 = imresize(mask, [455, 473]);

maskedImage = RGB.*mask2;
figure, imshow(maskedImage);

%end