%Ultimo passaggio per la creazione delle maschere
clc;
clear all;
close all;

files = dir('/Users/mauroloddo/Documents/MATLAB/SeedClasification/GT Canadians families/GTSolanaceae2/*.jpg'); %totale delle immagini da analizzare
N = length(files); %Numero immagini
path = '/Users/mauroloddo/Documents/MATLAB/SeedClasification/GT Canadians families/GTSolanaceae2/'; %path cartella

for l = 1:N
    imageName = files(l).name;          %nome dell'immagine
    string = strcat(path, imageName);   %path completo dell'immagine
    BW = imread(string);                 %immagine da analizzare
    
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
    stats = regionprops(BW2, 'All');

    area = 0;
    index = 0;
    for i=1:size(stats)
        if stats(i).Area > area
            area = stats(i).Area; %Salvo l'area maggiore corrispondente al seme principale
            index = i;            %Salvo il suo indice
        end
    end

        result = imcrop(BW2, stats(index).BoundingBox); %estraggo il bounding box del seme principale
        pixelList = regionprops(BW2, 'PixelList');


        for j=1:size(stats) %ciclo per ogni elemento
            if j ~= index   %Se la regione non è quella del seme principale viene riempita
                for k=1:size(pixelList(j).PixelList)
                    result(pixelList(j).PixelList(k,2), pixelList(j).PixelList(k,1)) = 0;
                end
            end
        end

    newImageFolder = '/Users/mauroloddo/Documents/MATLAB/SeedClasification/GT Canadians families/GTSolanaceae3';    %Nuova cartella di destinazione
    fullFileName = fullfile(newImageFolder, imageName);             %Nuovo path completo di nome
    imwrite(result, fullFileName);            %Immagine scritta nella nuova cartella
end
