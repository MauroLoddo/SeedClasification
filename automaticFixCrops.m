%Prende i semi rgb e li ritaglia, da usare prima di thresholdingConValoreSfondo
clc;
clear all;
close all;

classe = 'Vicia faba';
directory = strcat('/Users/mauroloddo/Documents/MATLAB/NewDatasets/NewDataset/', classe);
filesString = strcat(directory, '/*.jpg');
originalFiles= dir(filesString);
originalPath = strcat('/Users/mauroloddo/Documents/MATLAB/NewDatasets/NewDataset/', classe);

bwDirectory = strcat('/Users/mauroloddo/Documents/MATLAB/NewDatasets/GT NewDataset/GT', classe);
bwFilesString = strcat(bwDirectory, '/*.jpg');
bwFiles= dir(bwFilesString);
bwPath = bwDirectory;

directory2 = strcat('/Users/mauroloddo/Documents/MATLAB/NewDatasets/NewDataset2/', classe);
%originalFiles = dir('/Users/mauroloddo/Documents/MATLAB/SeedClasification/NewDataset/Amorpha fruticosa/*.jpg'); %totale delle immagini da analizzare
N = length(originalFiles); %Numero immagini
%originalPath = '/Users/mauroloddo/Documents/MATLAB/SeedClasification/NewDataset/Amorpha fruticosa/'; %path cartella immagini rgb

%bwFiles = dir('/Users/mauroloddo/Documents/MATLAB/SeedClasification/GT NewDataset/GTAmorpha fruticosa/*.jpg'); %totale immagini in bianco e nero
%bwPath = '/Users/mauroloddo/Documents/MATLAB/SeedClasification/GT NewDataset/GTAmorpha fruticosa/'; %path cartella immagini bw
for i = 1:N

    originalImageName = originalFiles(i).name;          %nome dell'immagine
    pathSenzaImmagine = strcat(originalPath, '/');
    originalString = strcat(pathSenzaImmagine, originalImageName);   %path completo dell'immagine
    I = imread(originalString);                 %immagine da analizzare

    bwImageName = bwFiles(i).name;          %nome dell'immagine
    bwPathSenzaImmagine = strcat(bwPath, '/');
    bwString = strcat(bwPathSenzaImmagine, bwImageName);   %path completo dell'immagine
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
    mkdir '/Users/mauroloddo/Documents/MATLAB/NewDatasets/NewDataset2/Vicia faba2';
    %Vengono divisi i semi in base ai bounding box che vengono trovati
    for j=1:size(stats)
        result = imcrop(I, stats(j).BoundingBox);
        newImageFolder = strcat(directory2, num2str(2));
        %newImageFolder = '/Users/mauroloddo/Documents/MATLAB/SeedClasification/NewDataset/Amorpha fruticosa2';%Nuova cartella di destinazione
        imageName = strcat(num2str(j),originalImageName);
        fullFileName = fullfile(newImageFolder, imageName);                                                        %Nuovo path completo di nome
        imwrite(result, fullFileName);                                                                             %Immagine scritta nella nuova cartella
    end
end


