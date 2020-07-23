BW = imread('GTAmaranthaceae\invasive_plants_seed_factsheet_amaranthus_tubriculatus_04cnsh_1476383162006_eng.jpg');

% elemento strutturante
se = strel('disk', 1);

% Preprocessing: opening (erosione + dilatazione)
BW2 = imopen(BW, se);
figure, imshow(BW2);
BW2 = imfill(BW2, 'holes');
BW2 = imbinarize(BW2);


% regionprops per ottenere i valori d'interesse
% dentro stats, trovi tutti i bounding box estrapolati dall'immagine
% che puoi poi usare con imcrop, inserendo come parametro proprio quel
% rettangolo con 4 valori
stats = regionprops(BW2);

figure, imshow(BW2);