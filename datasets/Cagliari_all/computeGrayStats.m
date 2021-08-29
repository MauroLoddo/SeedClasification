% compute colour stats

path = 'C:\Users\loand\Documents\GitHub\Tesisti\SeedClasification\datasets\Cagliari_all\';
images = dir([path '*.jpg']);

features = [];
areaT = 164;

for i = 1:length(images)

    RGB = imread( fullfile( path, images(i).name ) );
    
    [BW, maskedRGBImage] = createMask(RGB);
    
    G = rgb2gray(maskedRGBImage);
    
    stats = getStats(BW, G, areaT, 'GR');
    
    stats.label(:) = convertCharsToStrings( images(i).name );
    
    features = [features; stats];

end

writetable(features, 'Gray.csv');


