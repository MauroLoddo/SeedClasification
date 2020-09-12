files = dir('/Users/mauroloddo/Documents/MATLAB/SeedClasification/GT Canadians families/GTApiaceae/*.jpg'); %totale delle immagini da analizzare
N = length(originalFiles); %Numero immagini
path = '/Users/mauroloddo/Documents/MATLAB/SeedClasification/GT Canadians families/GTApiaceae/'; %path cartella immagini rgb

for i = 1:N
    
    imageName = files(i).name;          %nome dell'immagine
    string = strcat(path, imageName);   %path completo dell'immagine
    I = imread(string);                 %immagine da analizzare
    %figure,imshow(I);
    se = strel('disk', 2);
    
    I2 = imerode(I,se);              %erosione per eliminare piccole imperfezioni
    figure,imshow(I2);
    
    fullFileName = fullfile(path, imageName);                                            %Nuovo path completo di nome
    imwrite(result, fullFileName);           
end