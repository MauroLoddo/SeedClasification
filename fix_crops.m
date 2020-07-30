clc;
clear all;
close all;

BW = imread('/Users/mauroloddo/Documents/MATLAB/SeedClasification/GT Canadians families/GTAmaranthaceae2/1invasive_plants_seed_factsheet_amaranthus_retroflexus_04cnsh_1476382963209_eng.jpg');
I = imread('/Users/mauroloddo/Documents/MATLAB/SeedClasification/Canadians families/Amaranthaceae2/1invasive_plants_seed_factsheet_amaranthus_retroflexus_04cnsh_1476382963209_eng.jpg');
figure, imshow(BW);
% elemento strutturante
se = strel('disk', 1);

% Preprocessing: opening (erosione + dilatazione)
BW2 = imopen(BW, se);
BW2 = imfill(BW2, 'holes');
BW2 = imbinarize(BW2);

% regionprops per ottenere i valori d'interesse
% dentro stats, trovi tutti i bounding box estrapolati dall'immagine
% che puoi poi usare con imcrop, inserendo come parametro proprio quel
% rettangolo con 4 valori
stats = regionprops(BW2);


figure, imshow(BW2);

%-------------------------------------

pixel = I(1, 1); %valore primo pixel

for i=1:size(stats)
    
    result = imcrop(I, stats(i).BoundingBox);
    figure, imshow(result);
end

%-------------------------------------

result = imcrop(I, stats(1).BoundingBox);
    %result(~stats(i).BoundingBox) = 0; %set things not in the mask to zero
    figure, imshow(result);

    pixelList = regionprops(BW2, 'PixelList');
for j=1:size(pixelList(2).PixelList)
    
    pixelList(2).PixelList(j,1); %coordinata x
    pixelList(2).PixelList(j,2); %coordinata y
    
    result(pixelList(2).PixelList(j,2), pixelList(2).PixelList(j,1),1) = pixel;
    result(pixelList(2).PixelList(j,2), pixelList(2).PixelList(j,1),2) = pixel;
    result(pixelList(2).PixelList(j,2), pixelList(2).PixelList(j,1),3) = pixel;
end
    figure, imshow(result);
