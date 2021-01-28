clc;
clear all;
close all;
filesRGB = dir('/Users/mauroloddo/Documents/MATLAB/SeedClasification/Canadians families/Solanaceae2/*.jpg'); %totale delle immagini da analizzare
N = length(filesRGB); %Numero immagini
pathRGB = '/Users/mauroloddo/Documents/MATLAB/SeedClasification/Canadians families/Solanaceae2/'; %path cartella

filesBinary = dir('/Users/mauroloddo/Documents/MATLAB/SeedClasification/GT Canadians families/GTSolanaceae3/*.jpg'); %totale delle immagini da analizzare
pathBinary = '/Users/mauroloddo/Documents/MATLAB/SeedClasification/GT Canadians families/GTSolanaceae3/'; %path cartella

for l = 1:N
    imageNameRGB = filesRGB(l).name;          
    stringRGB = strcat(pathRGB, imageNameRGB);      %path completo dell'immagine
    RGB = imread(stringRGB);                        %immagine da analizzare
  
    imageNameBinary = filesBinary(l).name;                  %nome dell'immagine
    stringBinary = strcat(pathBinary, imageNameBinary);     %path completo dell'immagine
    mask = imread(stringBinary);                            %immagine da analizzare
   
    [r,c, channels] = size(RGB);    %ricavo la dimensione dell'immagine per ridimensionare la maschera
    mask2 = imresize(mask, [r,c]);

    %Switch utilizzato per controllare che nell'angolo preso come campione
    %non sia presente una porzione di seme invece dello sfondo
    pixel = RGB(1, 1);              %valore primo pixel
    for i=1:3
        if pixel < 120
            switch i
                case 1
                    pixel = RGB(1, c);

                case 2
                    pixel = RGB(r, 1);

                otherwise
                    pixel = RGB(r, c);
            end
        end
    end

    %Salvo i valori R G B
    R = RGB(:, :, 1); 
    G = RGB(:, :, 2); 
    B = RGB(:, :, 3);
    %Imposto i valori di rgb al valore del primo pixel 
    R(~mask2) = pixel;
    G(~mask2) = pixel;
    B(~mask2) = pixel;
    maskedImage = cat(3, R, G, B); %Ricreo l'immagine (la funzione cat concatena gli array)
 
    newImageFolder = '/Users/mauroloddo/Documents/MATLAB/SeedClasification/Canadians families/Solanaceae3';    %Nuova cartella di destinazione
    fullFileName = fullfile(newImageFolder, imageNameRGB);             %Nuovo path completo di nome
    imwrite(maskedImage, fullFileName);            %Immagine scritta nella nuova cartella
end