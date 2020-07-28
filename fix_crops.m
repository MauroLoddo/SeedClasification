BW = imread('/Users/mauroloddo/Documents/MATLAB/SeedClasification/GT Canadians families/GTAmaranthaceae/invasive_plants_seed_factsheet_amaranthus_retroflexus_04cnsh_1476382963209_eng.jpg');
I = imread('/Users/mauroloddo/Documents/MATLAB/SeedClasification/Canadians families/Amaranthaceae/invasive_plants_seed_factsheet_amaranthus_retroflexus_04cnsh_1476382963209_eng.jpg');
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

for i=1:size(stats)
    result = imcrop(I, stats(i).BoundingBox);
    figure, imshow(result);
end

