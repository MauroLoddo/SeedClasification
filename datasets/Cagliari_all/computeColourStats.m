% compute colour stats

path = 'C:\Users\loand\Documents\GitHub\Tesisti\SeedClasification\datasets\Cagliari_all\';
images = dir([path '*.jpg']);

features = [];
areaT = 164;


for i = 1:length(images)

    RGB = imread( fullfile( path, images(i).name ) );
    
    [BW, maskedRGBImage] = createMask(RGB);
    
    maskedHSVImage = rgb2hsv(maskedRGBImage);

    R = maskedRGBImage(:,:,1);
    G = maskedRGBImage(:,:,2);
    B = maskedRGBImage(:,:,3);

    H = maskedHSVImage(:,:,1);
    S = maskedHSVImage(:,:,2);
    V = maskedHSVImage(:,:,3);

    statsR = getStats(BW, R, areaT, 'R');
    statsG = getStats(BW, G, areaT, 'G');
    statsB = getStats(BW, B, areaT, 'B');
    statsH = getStats(BW, H, areaT, 'H');
    statsS = getStats(BW, S, areaT, 'S');
    statsV = getStats(BW, V, areaT, 'V');

    stats = [statsR, statsG, statsB, statsH, statsS, statsV];
    stats.label(:) = convertCharsToStrings( images(i).name );
    
    features = [features; stats];

end

writetable(features, 'RGB_HSV.csv');

