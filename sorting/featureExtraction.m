function oneF = featureExtraction(img, descriptor, color, graylevel, prepro)

if nargin == 4
    prepro = 'map';
elseif nargin == 3
    prepro = 'map';
    graylevel = 256;
elseif nargin == 2
    prepro = 'map';
    graylevel = 256;
    color = 'gray';
end

if ~contains(prepro,'none')
    if strcmp(prepro, 'u8')
        img = uint8(img);
    elseif strcmp(prepro, 'imu8')
        img = im2uint8(img);
    elseif strcmp(prepro, 'immatu8')
        img = im2uint8(mat2gray(img));
    elseif strcmp(prepro, 'u8+s')
        img = imadjust(uint8(img));
    elseif strcmp(prepro, 'imu8+s')
        img = imadjust(im2uint8(img));
    elseif strcmp(prepro, 'imu8+s')
        img = imadjust(im2uint8(mat2gray(img)));
    elseif strcmp(prepro, 'map')==1
        img = img + abs(min(img(:)));
        img = (img / (max(img(:))/256));
        img = uint8(img);
    end
end

scale = 256/graylevel;
img = img/scale;

C = strsplit(descriptor,'_');

if strcmp(color, 'gray')==1
    if contains(descriptor,'BRISK') %%%Brisk features
        points = detectBRISKFeatures(img);
        [oneF, ~] = extractFeatures(img, points);
    elseif contains(descriptor,'SURF') %%%Surf features
        points = detectSURFFeatures(img);
        [oneF, ~] = extractFeatures(img, points);
    elseif contains(descriptor,'MSER') %%%MSER features
        regions = detectMSERFeatures(img);
        [oneF, ~] = extractFeatures(img,regions,'Upright',true);
    elseif contains(descriptor,'HOG') %%%HOG features 
        oneF = extractHOGFeatures(img);
    elseif contains(C{1},'HM') %%%Hu Moments
        if length(C) > 1
            if contains(C{2},'CM')
                if length(C) == 2
                    [GLCM, ~] = GLCoOcc(img,'graylevel',256);
                else
                    offsets = dist2offset(str2double(C{3}), 'PET');
                    [GLCM, ~] = GLCoOcc(img, 'offsets', offsets, 'graylevel',256);
                end
                oneF = [];
                for i = 1:size(GLCM,3)
                    oneF = [oneF;reshape(HM(GLCM(:,:,i)),[],1)];
                end
            elseif contains(C{2},'LBP')
                if contains(C{2},'ri')
                    [img,~]= im2lbp(img, 1, 8, 'ri');
                else
                    [img, ~]= im2lbp(img, 1, 8);
                end
                oneF = reshape(HM(img), [], 1);
            else
                error('Unsupported method for feature extraction');
            end
        else
            oneF = reshape(HM(img), [], 1);
        end
    elseif contains(C{1},'ZM') %%%Zernike Moments
        ord = str2double(C{2});
        num = str2double(C{3});
        if length(C) > 3
            if contains(C{4},'CM')
                if length(C) == 4
                    [GLCM, ~] = GLCoOcc(img,'graylevel',256);
                else
                    offsets = dist2offset(str2double(C{5}), 'PET');
                    [GLCM, ~] = GLCoOcc(img, 'offsets', offsets, 'graylevel',256);
                end
                oneF = [];
                for i = 1:size(GLCM,3)
                    oneF = [oneF;reshape(ZM(GLCM(:,:,i),ord,num),[],1)];
                end
            elseif contains(C{4},'LBP')
                if contains(C{4},'ri')
                    [img,~]= im2lbp(img, 1, 8, 'ri');
                else
                    [img, ~]= im2lbp(img, 1, 8);
                end
                oneF = reshape(ZM(img,ord,num), [], 1);
            else
                error('Unsupported method for feature extraction');
            end
        else
            oneF = reshape(ZM(img,ord,num), [], 1);
        end
    elseif contains(C{1},'LM') %%%Legendre Moments
        ord = str2double(C{2});
        if length(C) > 2
            if contains(C{3},'CM')
                disp('CM')
                if length(C) == 3
                    [GLCM, ~] = GLCoOcc(img,'graylevel',256);
                else
                    offsets = dist2offset(str2double(C{4}), 'PET');
                    [GLCM, ~] = GLCoOcc(img, 'offsets', offsets, 'graylevel',256);
                end
                oneF = [];
                for i = 1:size(GLCM,3)
                    if contains(C{1},'GS')
                        disp('Legendre Giuseppe Simpson CM')
                        oneF = [oneF;reshape(LMGS(GLCM(:,:,i),ord),[],1)];
                    elseif contains(C{1},'G')
                        disp('Legendre Giuseppe CM')
                        oneF = [oneF;reshape(LMG(GLCM(:,:,i),ord),[],1)];
                    else
                        disp('Legendre Classico CM')
                        oneF = [oneF;reshape(LM(GLCM(:,:,i),ord),[],1)];
                    end
                end
            elseif contains(C{3},'LBP')
                if contains(C{3},'ri')
                    [img,~]= im2lbp(img, 1, 8, 'ri');
                else
                    [img,~]= im2lbp(img, 1, 8);
                end
                if contains(C{1},'GS')
                    disp('Legendre Giuseppe Simpson LBP')
                    oneF = LMGS(img, ord)';
                elseif contains(C{1},'G')
                    disp('Legendre Giuseppe LBP')
                    oneF = LMG(img, ord)';
                else
                    disp('Legendre Classico LBP')
                    oneF = reshape(LM(img, ord), [], 1);
                end
            else
                error('Unsupported method for feature extraction');
            end
        else
            if contains(C{1},'GS')
                disp('Legendre Giuseppe Simpson')
                oneF = LMGS(img, ord)'; 
            elseif contains(C{1},'G')
                disp('Legendre Giuseppe')
                oneF = LMG(img, ord)';
            else
                disp('Legendre Classico')
                oneF = reshape(LM(img, ord), [], 1);
            end
        end
    elseif contains(C{1},'CH') %%%Chebichev Moments
        ord = str2double(C{2});
        if length(C) > 2
            if contains(C{3},'CM')
                if length(C) == 3
                    [GLCM, ~] = GLCoOcc(img,'graylevel',256);
                else
                    offsets = dist2offset(str2double(C{4}), 'PET');
                    [GLCM, ~] = GLCoOcc(img, 'offsets', offsets, 'graylevel',256);
                end
                oneF = [];
                for i = 1:size(GLCM,3)
                    if contains(C{1},'due')
                        disp('Chebychev due CM')
                        oneF = [oneF;reshape(CHdue(GLCM(:,:,i),ord),[],1)];
                    else
                        disp('Chebychev CM')
                        oneF = [oneF;reshape(CH(GLCM(:,:,i),ord),[],1)];
                    end
                end
            else
                error('Unsupported method for feature extraction');
            end
        else
            if contains(C{1},'due')
                disp('Chebychev due')
                oneF = reshape(CHdue(img, ord), [], 1);
            else
                disp('Chebychev')
                oneF = reshape(CH(img, ord), [], 1);
            end
        end
    elseif contains(descriptor,'TSM') %%%texture Spectrum Moments
        if contains(descriptor,'CM')
            [GLCM, ~] = GLCoOcc(img);
            oneF = reshape(TSM(GLCM(:,:,1)), [], 1);
            oneF = [oneF;reshape(TSM(GLCM(:,:,2)),[],1)];
            oneF = [oneF;reshape(TSM(GLCM(:,:,3)),[],1)];
            oneF = [oneF;reshape(TSM(GLCM(:,:,4)),[],1)];
        elseif contains(descriptor,'LBP')
            if contains(descriptor,'ri')
                [img,~]= im2lbp(img, 1, 8, 'ri');
            else
                [img,~]= im2lbp(img, 1, 8);
            end
            oneF = reshape(TSM(img), [], 1);
        else
            oneF = reshape(TSM(img), [], 1);
        end      
    elseif contains(descriptor,'CLBP') %%%Local Binary Pattern    
        disp("CLBP")
        N = cell2mat(regexp(descriptor,'\d*','Match'));
        if numel(N)==2
            ord = str2num(N(1));
            num = str2num(N(2));
        else
            ord = str2num(N(1));
            num = str2num(N(2:3));
        end
        if contains(descriptor,'CM')
            [GLCM, ~] = GLCoOcc(img);
            [~, H1]= im2clbp(GLCM(:,:,1), ord, num, 'ri');
            [~, H2]= im2clbp(GLCM(:,:,2), ord, num, 'ri');
            [~, H3]= im2clbp(GLCM(:,:,3), ord, num, 'ri');
            [~, H4]= im2clbp(GLCM(:,:,4), ord, num, 'ri');
            oneF = [H1,H2,H3,H4]';
        else
            [~, ~, ~, H1, H2]= im2clbp(img, ord, num, 'ri');
            oneF = [H1,H2]';
        end  
    elseif contains(descriptor,'LBP') %%%Local Binary Pattern    
        N = cell2mat(regexp(descriptor,'\d*','Match'));
        if numel(N)==2
            ord = str2num(N(1));
            num = str2num(N(2));
        else
            ord = str2num(N(1));
            num = str2num(N(2:3));
        end
        if contains(descriptor,'CM')
            [GLCM, ~] = GLCoOcc(img);
            [~, H1]= im2lbp(GLCM(:,:,1), ord, num, 'ri');
            [~, H2]= im2lbp(GLCM(:,:,2), ord, num, 'ri');
            [~, H3]= im2lbp(GLCM(:,:,3), ord, num, 'ri');
            [~, H4]= im2lbp(GLCM(:,:,4), ord, num, 'ri');
            oneF = [H1,H2,H3,H4]';
        else
            [~, H]= im2lbp(img, ord, num, 'ri');
            oneF = H';
        end   
    elseif contains(descriptor,'CM') %%%co-occurrence matrix
        [GLCM, ~] = GLCoOcc(img);
        if contains(descriptor,'128')
            GLCM = imresize(GLCM, 0.5);
        end
        if contains(descriptor,'u')
            oneF = CMu(GLCM);
        elseif contains(descriptor,'ri')
            oneF = CMri(GLCM);
        else
            oneF = CM(GLCM);
        end
    elseif contains(descriptor,'DM') %%%difference matrix
        if contains(descriptor,'128')
            [~, Dhists] = GLDiff(img/2);
            Dhists = Dhists(1:128,:);
        else
            [~, Dhists] = GLDiff(img);
        end
        if contains(descriptor,'u')
            oneF = mean(Dhists,2);
        elseif contains(descriptor,'ri')
            oneF = histri(Dhists');
        else
            oneF = Dhists(:);
        end    
    elseif contains(descriptor,'SM') %%%sum matrix
        if contains(descriptor,'128')
            [~, Shists] = GLSum(img/2);
            Shists = Shists(1:256,:);
        else
            [~, Shists] = GLSum(img);
        end
        if contains(descriptor,'u')
            oneF = mean(Shists,2);
        elseif contains(descriptor,'ri')
            oneF = histri(Shists');
        else
            oneF = Shists(:);
        end  
    elseif contains(descriptor,'DMSM') %%%difference and sum matrix
        if contains(descriptor,'128')
            [~, Dhists] = GLDiff(img/2);
            [~, Shists] = GLSum(img/2);
            Dhists = Dhists(1:128,:);
            Shists = Shists(1:256,:);
        else
            [~, Dhists] = GLDiff(img);
            [~, Shists] = GLSum(img);
        end
        if contains(descriptor,'u')
            oneF = mean([Dhists;Shists],2); 
        elseif contains(descriptor,'ri')
            oneF = histri([Dhists;Shists]'); 
        else
            oneF = [Dhists(:);Shists(:)];
        end 
    else
        error('Unsupported method for feature extraction');
    end

% else
%     Ch1 = img(:,:,1);
%     Ch2 = img(:,:,2);
%     Ch3 = img(:,:,3);
%     switch descriptor
%         case 'GLCM'
%             oneF = reshape(GLCM13(Ch1,Ch1)',[],1);
%             oneF = [oneF;reshape(GLCM13(Ch2,Ch2)',[],1)];
%             oneF = [oneF;reshape(GLCM13(Ch3,Ch3)',[],1)];
%         case 'GLCMri'
%             oneF = GLCM13ri(Ch1,Ch1);
%             oneF = [oneF;GLCM13ri(Ch2,Ch2)];
%             oneF = [oneF;GLCM13ri(Ch3,Ch3)];
%         case 'GLCMriCC'
%             oneF = GLCM13ri(Ch1,Ch1);
%             oneF = [oneF;GLCM13ri(Ch2,Ch2)];
%             oneF = [oneF;GLCM13ri(Ch3,Ch3)];
%             oneF = [oneF;GLCM13ri(Ch1,Ch2)];
%             oneF = [oneF;GLCM13ri(Ch1,Ch3)];
%             oneF = [oneF;GLCM13ri(Ch2,Ch3)];
%         case 'HM'
%             oneF = reshape(HM(Ch1),[],1);
%             oneF = [oneF;reshape(HM(Ch2),[],1)];
%             oneF = [oneF;reshape(HM(Ch3),[],1)];
%         case 'HMCM'
%             [GLCM, ~] = GLCoOcc(Ch1);
%             oneF = reshape(HM(GLCM(:,:,1)),[],1);
%             oneF = [oneF;reshape(HM(GLCM(:,:,2)),[],1)];
%             oneF = [oneF;reshape(HM(GLCM(:,:,3)),[],1)];
%             oneF = [oneF;reshape(HM(GLCM(:,:,4)),[],1)];
%             [GLCM, ~] = GLCoOcc(Ch2);
%             oneF = [oneF;reshape(HM(GLCM(:,:,1)),[],1)];
%             oneF = [oneF;reshape(HM(GLCM(:,:,2)),[],1)];
%             oneF = [oneF;reshape(HM(GLCM(:,:,3)),[],1)];
%             oneF = [oneF;reshape(HM(GLCM(:,:,4)),[],1)];
%             [GLCM, ~] = GLCoOcc(Ch3);
%             oneF = [oneF;reshape(HM(GLCM(:,:,1)),[],1)];
%             oneF = [oneF;reshape(HM(GLCM(:,:,2)),[],1)];
%             oneF = [oneF;reshape(HM(GLCM(:,:,3)),[],1)];
%             oneF = [oneF;reshape(HM(GLCM(:,:,4)),[],1)];
%         case 'HMCMCC'
%             [GLCM, ~] = GLCoOcc(Ch1);
%             oneF = reshape(HM(GLCM(:,:,1)),[],1);
%             oneF = [oneF;reshape(HM(GLCM(:,:,2)),[],1)];
%             oneF = [oneF;reshape(HM(GLCM(:,:,3)),[],1)];
%             oneF = [oneF;reshape(HM(GLCM(:,:,4)),[],1)];
%             [GLCM, ~] = GLCoOcc(Ch2);
%             oneF = [oneF;reshape(HM(GLCM(:,:,1)),[],1)];
%             oneF = [oneF;reshape(HM(GLCM(:,:,2)),[],1)];
%             oneF = [oneF;reshape(HM(GLCM(:,:,3)),[],1)];
%             oneF = [oneF;reshape(HM(GLCM(:,:,4)),[],1)];
%             [GLCM, ~] = GLCoOcc(Ch3);
%             oneF = [oneF;reshape(HM(GLCM(:,:,1)),[],1)];
%             oneF = [oneF;reshape(HM(GLCM(:,:,2)),[],1)];
%             oneF = [oneF;reshape(HM(GLCM(:,:,3)),[],1)];
%             oneF = [oneF;reshape(HM(GLCM(:,:,4)),[],1)];
%             [GLCM, ~] = GLCoOcc(Ch1, Ch2);
%             oneF = [oneF;reshape(HM(GLCM(:,:,1)),[],1)];
%             oneF = [oneF;reshape(HM(GLCM(:,:,2)),[],1)];
%             oneF = [oneF;reshape(HM(GLCM(:,:,3)),[],1)];
%             oneF = [oneF;reshape(HM(GLCM(:,:,4)),[],1)];
%             [GLCM, ~] = GLCoOcc(Ch1, Ch3);
%             oneF = [oneF;reshape(HM(GLCM(:,:,1)),[],1)];
%             oneF = [oneF;reshape(HM(GLCM(:,:,2)),[],1)];
%             oneF = [oneF;reshape(HM(GLCM(:,:,3)),[],1)];
%             oneF = [oneF;reshape(HM(GLCM(:,:,4)),[],1)];
%             [GLCM, ~] = GLCoOcc(Ch2, Ch3);
%             oneF = [oneF;reshape(HM(GLCM(:,:,1)),[],1)];
%             oneF = [oneF;reshape(HM(GLCM(:,:,2)),[],1)];
%             oneF = [oneF;reshape(HM(GLCM(:,:,3)),[],1)];
%             oneF = [oneF;reshape(HM(GLCM(:,:,4)),[],1)];
%         case 'HMLBPri'
%             [Ch1, ~]= im2lbp(Ch1, 1, 8, 'ri');
%             oneF = reshape(HM(Ch1), [], 1);
%             [Ch2, ~]= im2lbp(Ch2, 1, 8, 'ri');
%             oneF = [oneF;reshape(HM(Ch2), [], 1)];            
%             [Ch3, ~]= im2lbp(Ch3, 1, 8, 'ri');
%             oneF = [oneF;reshape(HM(Ch3), [], 1)];
%         case 'ZM77'
%             oneF = reshape(ZM(Ch1,7,7),[],1);
%             oneF = [oneF;reshape(ZM(Ch2,7,7),[],1)];
%             oneF = [oneF;reshape(ZM(Ch3,7,7),[],1)];
%         case 'ZM77CM'
%            [GLCM, ~] = GLCoOcc(Ch1);
%             oneF = reshape(ZM(GLCM(:,:,1),7,7), [], 1);
%             oneF = [oneF;reshape(ZM(GLCM(:,:,2),7,7),[],1)];
%             oneF = [oneF;reshape(ZM(GLCM(:,:,3),7,7),[],1)];
%             oneF = [oneF;reshape(ZM(GLCM(:,:,4),7,7),[],1)];  
%            [GLCM, ~] = GLCoOcc(Ch2);
%             oneF = [oneF;reshape(ZM(GLCM(:,:,1),7,7),[],1)];
%             oneF = [oneF;reshape(ZM(GLCM(:,:,2),7,7),[],1)];
%             oneF = [oneF;reshape(ZM(GLCM(:,:,3),7,7),[],1)];
%             oneF = [oneF;reshape(ZM(GLCM(:,:,4),7,7),[],1)];             
%             [GLCM, ~] = GLCoOcc(Ch3);
%             oneF = [oneF;reshape(ZM(GLCM(:,:,1),7,7),[],1)];
%             oneF = [oneF;reshape(ZM(GLCM(:,:,2),7,7),[],1)];
%             oneF = [oneF;reshape(ZM(GLCM(:,:,3),7,7),[],1)];
%             oneF = [oneF;reshape(ZM(GLCM(:,:,4),7,7),[],1)];  
%         case 'ZM77CMCC'
%            [GLCM, ~] = GLCoOcc(Ch1);
%             oneF = reshape(ZM(GLCM(:,:,1),7,7), [], 1);
%             oneF = [oneF;reshape(ZM(GLCM(:,:,2),7,7),[],1)];
%             oneF = [oneF;reshape(ZM(GLCM(:,:,3),7,7),[],1)];
%             oneF = [oneF;reshape(ZM(GLCM(:,:,4),7,7),[],1)];  
%            [GLCM, ~] = GLCoOcc(Ch2);
%             oneF = [oneF;reshape(ZM(GLCM(:,:,1),7,7),[],1)];
%             oneF = [oneF;reshape(ZM(GLCM(:,:,2),7,7),[],1)];
%             oneF = [oneF;reshape(ZM(GLCM(:,:,3),7,7),[],1)];
%             oneF = [oneF;reshape(ZM(GLCM(:,:,4),7,7),[],1)];             
%             [GLCM, ~] = GLCoOcc(Ch3);
%             oneF = [oneF;reshape(ZM(GLCM(:,:,1),7,7),[],1)];
%             oneF = [oneF;reshape(ZM(GLCM(:,:,2),7,7),[],1)];
%             oneF = [oneF;reshape(ZM(GLCM(:,:,3),7,7),[],1)];
%             oneF = [oneF;reshape(ZM(GLCM(:,:,4),7,7),[],1)];  
%            [GLCM, ~] = GLCoOcc(Ch1, Ch2);
%             oneF = [oneF;reshape(ZM(GLCM(:,:,1),7,7),[],1)];
%             oneF = [oneF;reshape(ZM(GLCM(:,:,2),7,7),[],1)];
%             oneF = [oneF;reshape(ZM(GLCM(:,:,3),7,7),[],1)];
%             oneF = [oneF;reshape(ZM(GLCM(:,:,4),7,7),[],1)];  
%            [GLCM, ~] = GLCoOcc(Ch1, Ch3);
%             oneF = [oneF;reshape(ZM(GLCM(:,:,1),7,7),[],1)];
%             oneF = [oneF;reshape(ZM(GLCM(:,:,2),7,7),[],1)];
%             oneF = [oneF;reshape(ZM(GLCM(:,:,3),7,7),[],1)];
%             oneF = [oneF;reshape(ZM(GLCM(:,:,4),7,7),[],1)];             
%             [GLCM, ~] = GLCoOcc(Ch2, Ch3);
%             oneF = [oneF;reshape(ZM(GLCM(:,:,1),7,7),[],1)];
%             oneF = [oneF;reshape(ZM(GLCM(:,:,2),7,7),[],1)];
%             oneF = [oneF;reshape(ZM(GLCM(:,:,3),7,7),[],1)];
%             oneF = [oneF;reshape(ZM(GLCM(:,:,4),7,7),[],1)];  
%         case 'ZM77LBPri'
%            [Ch1,~]= im2lbp(Ch1, 1, 8, 'ri');
%             oneF = reshape(ZM(Ch1,7,7), [], 1); 
%             [Ch2,~]= im2lbp(Ch2, 1, 8, 'ri');
%             oneF = [oneF;reshape(ZM(Ch2,7,7), [], 1)]; 
%             [Ch3,~]= im2lbp(Ch3, 1, 8, 'ri');
%             oneF = [oneF;reshape(ZM(Ch3,7,7), [], 1)]; 
%         case 'LM3'
%             oneF = reshape(LM(Ch1,5),[],1);           
%             oneF = [oneF;reshape(LM(Ch2,5),[],1)];
%             oneF = [oneF;reshape(LM(Ch3,5),[],1)];
%         case 'LM5CM'
%             [GLCM, ~] = GLCoOcc(Ch1);
%             oneF = reshape(LM(GLCM(:,:,1),5), [], 1);
%             oneF = [oneF;reshape(LM(GLCM(:,:,2),5),[],1)];
%             oneF = [oneF;reshape(LM(GLCM(:,:,3),5),[],1)];
%             oneF = [oneF;reshape(LM(GLCM(:,:,4),5),[],1)];
%             [GLCM, ~] = GLCoOcc(Ch2);
%             oneF = [oneF;reshape(LM(GLCM(:,:,1),5),[],1)];
%             oneF = [oneF;reshape(LM(GLCM(:,:,2),5),[],1)];
%             oneF = [oneF;reshape(LM(GLCM(:,:,3),5),[],1)];
%             oneF = [oneF;reshape(LM(GLCM(:,:,4),5),[],1)];
%             [GLCM, ~] = GLCoOcc(Ch3);
%             oneF = [oneF;reshape(LM(GLCM(:,:,1),5),[],1)];
%             oneF = [oneF;reshape(LM(GLCM(:,:,2),5),[],1)];
%             oneF = [oneF;reshape(LM(GLCM(:,:,3),5),[],1)];
%             oneF = [oneF;reshape(LM(GLCM(:,:,4),5),[],1)];
%         case 'LM5CMCC'
%             [GLCM, ~] = GLCoOcc(Ch1);
%             oneF = reshape(LM(GLCM(:,:,1),5), [], 1);
%             oneF = [oneF;reshape(LM(GLCM(:,:,2),5),[],1)];
%             oneF = [oneF;reshape(LM(GLCM(:,:,3),5),[],1)];
%             oneF = [oneF;reshape(LM(GLCM(:,:,4),5),[],1)];
%             [GLCM, ~] = GLCoOcc(Ch2);
%             oneF = [oneF;reshape(LM(GLCM(:,:,1),5),[],1)];
%             oneF = [oneF;reshape(LM(GLCM(:,:,2),5),[],1)];
%             oneF = [oneF;reshape(LM(GLCM(:,:,3),5),[],1)];
%             oneF = [oneF;reshape(LM(GLCM(:,:,4),5),[],1)];
%             [GLCM, ~] = GLCoOcc(Ch3);
%             oneF = [oneF;reshape(LM(GLCM(:,:,1),5),[],1)];
%             oneF = [oneF;reshape(LM(GLCM(:,:,2),5),[],1)];
%             oneF = [oneF;reshape(LM(GLCM(:,:,3),5),[],1)];
%             oneF = [oneF;reshape(LM(GLCM(:,:,4),5),[],1)];
%             [GLCM, ~] = GLCoOcc(Ch1, Ch2);
%             oneF = [oneF;reshape(LM(GLCM(:,:,1),5),[],1)];
%             oneF = [oneF;reshape(LM(GLCM(:,:,2),5),[],1)];
%             oneF = [oneF;reshape(LM(GLCM(:,:,3),5),[],1)];
%             oneF = [oneF;reshape(LM(GLCM(:,:,4),5),[],1)];
%             [GLCM, ~] = GLCoOcc(Ch1, Ch3);
%             oneF = [oneF;reshape(LM(GLCM(:,:,1),5),[],1)];
%             oneF = [oneF;reshape(LM(GLCM(:,:,2),5),[],1)];
%             oneF = [oneF;reshape(LM(GLCM(:,:,3),5),[],1)];
%             oneF = [oneF;reshape(LM(GLCM(:,:,4),5),[],1)];
%             [GLCM, ~] = GLCoOcc(Ch2, Ch3);
%             oneF = [oneF;reshape(LM(GLCM(:,:,1),5),[],1)];
%             oneF = [oneF;reshape(LM(GLCM(:,:,2),5),[],1)];
%             oneF = [oneF;reshape(LM(GLCM(:,:,3),5),[],1)];
%             oneF = [oneF;reshape(LM(GLCM(:,:,4),5),[],1)];
%         case 'LM3LBPri'
%             [Ch1,~]= im2lbp(Ch1, 1, 8, 'ri');
%             oneF = reshape(LM(Ch1, 3), [], 1);
%             [Ch2,~]= im2lbp(Ch2, 1, 8, 'ri');
%             oneF = [oneF;reshape(LM(Ch2, 3), [], 1)];
%             [Ch3,~]= im2lbp(Ch3, 1, 8, 'ri');
%             oneF = [oneF;reshape(LM(Ch3, 3), [], 1)];
%         case 'TSM'
%             oneF = reshape(TSM(Ch1),[],1);
%             oneF = [oneF;reshape(TSM(Ch2),[],1)];
%             oneF = [oneF;reshape(TSM(Ch3),[],1)];
%         case 'LBP18'
%             [~, H1]= im2lbp(Ch1, 1, 8, 'ri');
%             [~, H2]= im2lbp(Ch2, 1, 8, 'ri');
%             [~, H3]= im2lbp(Ch3, 1, 8, 'ri');
%             oneF = [H1',H2',H3'];
%         otherwise
%             error('Unsupported method for feature extraction');
%     end
end

%-------------------------------------------------------------------------
function oneF = histri(hists)

[m,n] = size(hists);
oneF = [];
for j = 1:n %using eig
    mat = hists(:,j);
    for i = 1:m-1
        mat = [mat,circshift(hists(:,j),-i)];
    end
    tmp = eig(mat);
    oneF = [oneF, tmp(end-1), tmp(end)/m];
end
oneF = oneF';

%--------------------------------------------------------------------------
   
function featureMatrix = CM(GLCM)

id = (triu(ones(size(GLCM,1))))==1;
id = repmat(id, 1, 1, size(GLCM,3));
featureMatrix = GLCM(id);

%-------------------------------------------------------------------------
function oneF = CMu(GLCM)

featureVector = CM(GLCM);
featureMatrix = reshape(featureVector, [], size(GLCM,3))';
oneF = mean(featureMatrix);

%-------------------------------------------------------------------------
function oneF = CMri(GLCM)

featureVector = CM(GLCM);
featureMatrix = reshape(featureVector, [], size(GLCM,3))';
oneF = histri(featureMatrix);

%--------------------------------------------------------------------------
function featureMatrix = HM(img)

featureMatrix = Hu_Moments(img);

%--------------------------------------------------------------------------
function featureMatrix = ZM(img,ord, rep)

featureMatrix = Zernike_Moments(img,ord, rep);

%--------------------------------------------------------------------------
function featureMatrix = LM(img, ord)

featureMatrix = Legendre_Moments(img, ord);

%--------------------------------------------------------------------------
function featureMatrix = LMG(img, ord)

featureMatrix = legmoms_vec(img, ord, 0);

%--------------------------------------------------------------------------
function featureMatrix = LMGS(img, ord)

featureMatrix = legmoms_vec(img, ord, 1);

%--------------------------------------------------------------------------
function featureMatrix = CH(img, ord)

featureMatrix = dchebmoms_vec(img, ord);

%--------------------------------------------------------------------------
function featureMatrix = CHdue(img, ord)

featureMatrix = cheb2moms_vec(img,ord);

%--------------------------------------------------------------------------
function featureMatrix = TSM(img)

featureMatrix = Spectral_Feat(img);