path_old = 'C:\Users\loand\Documents\GitHub\Tesisti\SeedClasification\datasets\Cagliari';
%path_old = 'C:\Users\loand\Documents\GitHub\Tesisti\SeedClasification\datasets\Canada'

path_new = 'C:\Users\loand\Documents\GitHub\Tesisti\SeedClasification\datasets\Cagliari_bis';
%path_new = 'C:\Users\loand\Documents\GitHub\Tesisti\SeedClasification\datasets\Canada_bis'

subfolders = dir(path_old);

CREATE = 1;

padding = 16;
margin = padding/2;


% subfolders creation
if CREATE == 1
    for i = 3:length(subfolders)

        subfolder_name = subfolders(i).name;
        mkdir(fullfile( path_new, subfolders(i).name) );
    end
end


for i = 3:length(subfolders)
    
    subfolder_name = subfolders(i).name;
    
    A = dir( fullfile( path_old, subfolder_name) );
    A = A(3: end);
    nFiles = size(A,1);
    col = uint8([134 219 243]); 
    for k= 1:nFiles
        img_name = A(k).name;
        I = imread(img_name);
        [M, N, p] = size(I);
        I_new = uint8(zeros(M+padding,N+padding,p));
        I_new(:,:,1) = col(1);
        I_new(:,:,2) = col(2);
        I_new(:,:,3) = col(3);
        I_new(margin+1:end-margin, margin+1:end-margin,: ) = I(:,:,: );
        name_file = fullfile( path_new, subfolder_name, img_name );
        imwrite(I_new, name_file);
    end 
end