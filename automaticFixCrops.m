clc;
clear all;
close all;

originalFiles = dir('/Users/mauroloddo/Documents/MATLAB/SeedClasification/Canadians families/Amaranthaceae/*.jpg'); %totale delle immagini da analizzare
N = length(originalFiles); %Numero immagini
originalPath = '/Users/mauroloddo/Documents/MATLAB/SeedClasification/Canadians families/Amaranthaceae/'; %path cartella immagini rgb

bwFiles = dir('/Users/mauroloddo/Documents/MATLAB/SeedClasification/GT Canadians families/GTAmaranthaceae/*.jpg'); %totale immagini in bianco e nero
bwPath = '/Users/mauroloddo/Documents/MATLAB/SeedClasification/GT Canadians families/GTAmaranthaceae/'; %path cartella immagini bw
for i = 1:N
    originalImageName = originalFiles(i).name;          %nome dell'immagine
    originalString = strcat(originalPath, originalImageName);   %path completo dell'immagine
    I = imread(originalString);                 %immagine da analizzare
    
    
    
    bwImageName = bwFiles(i).name;          %nome dell'immagine
    bwString = strcat(bwPath, bwImageName);   %path completo dell'immagine
    BW = imread(bwString);                 %immagine da analizzare
    
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


    %-------------------------------------

    for j=1:size(stats)
        result = imcrop(I, stats(j).BoundingBox);
        %figure, imshow(result);
        newImageFolder = '/Users/mauroloddo/Documents/MATLAB/SeedClasification/Canadians families/Amaranthaceae2';    %Nuova cartella di destinazione
        imageName = strcat(num2str(j),originalImageName);
        fullFileName = fullfile(newImageFolder, imageName);                                            %Nuovo path completo di nome
        imwrite(result, fullFileName);                                                                    %Immagine scritta nella nuova cartella
    end
    
    
end


