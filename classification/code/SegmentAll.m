path_old = 'C:\Users\loand\Documents\GitHub\Tesisti\SeedClasification\datasets\Cagliari_bis';
%path_old = 'C:\Users\loand\Documents\GitHub\Tesisti\SeedClasification\datasets\Canada'

path_new = 'C:\Users\loand\Documents\GitHub\Tesisti\SeedClasification\datasets\Cagliari_quater';
%path_new = 'C:\Users\loand\Documents\GitHub\Tesisti\SeedClasification\datasets\Canada_tris'

CREATE = 1;

subfolders = dir(path_old);

% subfolders creation
if CREATE == 1
    for i = 3:length(subfolders)

        subfolder_name = subfolders(i).name;
        mkdir(fullfile( path_new, subfolders(i).name) );
        mkdir(fullfile( path_new, subfolders(i).name, 'BW') );
        mkdir(fullfile( path_new, subfolders(i).name, 'Gray') );
        mkdir(fullfile( path_new, subfolders(i).name, 'RGB') );
    end
end


for i = 3:length(subfolders)
    
    subfolder_name = subfolders(i).name;
    
    images = dir( fullfile( path_old, subfolder_name) );
    images = images(3: end);
    nImages = size(images,1);

    for k = 1:nImages
        img_name = images(k).name;
        im = imread( fullfile(images(k).folder, images(k).name) );
        
        if(size(im, 3) == 3)
            % Convert RGB to grayscale
            imgray = rgb2gray(im);
        else
            imgray = im;
        end
        
        [bw, ~] = segmentationCagliari(im);
        
        baselineFilename = fullfile( path_new, subfolder_name );
        BWFilename = fullfile( baselineFilename, 'BW', img_name );
        GrayFilename = fullfile( baselineFilename, 'Gray', img_name );
        RGBFilename = fullfile( baselineFilename, 'RGB', img_name );
        
        imwrite(bw, BWFilename);
        imwrite(imgray, GrayFilename);
        imwrite(im, RGBFilename);

        
    end 
end