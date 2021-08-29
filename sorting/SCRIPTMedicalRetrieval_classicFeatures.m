computePerformances = 1;
saveTables = 1;
savePlotsVariingPrePro = 0;
savePlotsVariingDesc = 1;


warning off;
codeFolder = pwd;
%WINDOWS
sep = '\';

sourcePath     = 'C:\Users\loand\Documents\GitHub\Tesisti\SeedClasification\datasets';
labelsPath     = 'C:\Users\loand\Documents\GitHub\Tesisti\SeedClasification\sorting\Classic\Labels';
featsPath      = 'C:\Users\loand\Documents\GitHub\Tesisti\SeedClasification\sorting\Classic\Features';
retrievePath   = 'C:\Users\loand\Documents\GitHub\Tesisti\SeedClasification\sorting\Classic\Retrieval';
perfPath      = 'C:\Users\loand\Documents\GitHub\Tesisti\SeedClasification\sorting\Classic\Performance';  

datasets       = {'Cagliari', 'Canada'};
datasetsname   = {'Cagliari', 'Canada'};
similarity = {'euclidean'; 'cityblock'; 'minkowski'; 'chebychev'; 'cosine'; 'correlation'; 'spearman'; 'camberra'; 'D1'; 'chi2'; 'KLDiv'};
similarity = {'euclidean', 'D1'};
graylevel = [256, 128, 64, 32, 16];
graylevel = [256];
prepro = ["none", "imu8", "imu8+s", "immatu8", "immatu8+s", "map"];
prepro = ["none"];
postpro = ["nfeat"];
postpro = ["none"];
descriptors      = {'HM',...
                    'TSM',...
                    'ZM_4_2','ZM_4_4','ZM_5_3','ZM_5_5','ZM_6_2','ZM_6_4','ZM_6_6','ZM_7_3','ZM_7_5','ZM_7_7','ZM_7_8','ZM_7_9','ZM_8_2','ZM_8_4','ZM_8_6','ZM_8_8','ZM_9_3','ZM_9_5','ZM_9_7','ZM_9_9','ZM_9_11','ZM_10_2','ZM_10_4','ZM_10_6','ZM_10_8','ZM_10_10',...
                    'LMG_3','LMG_4','LMG_5','LMG_6','LMG_7','LMG_8','LMG_9','LMG_10',...
                    'LMGS_3','LMGS_4','LMGS_5','LMGS_6','LMGS_7','LMGS_8','LMGS_9','LMGS_10',...
                    'CH_3','CH_4','CH_5','CH_6','CH_7','CH_8','CH_9','CH_10',...
                    'CHdue_3','CHdue_4','CHdue_5','CHdue_6','CHdue_7','CHdue_8','CHdue_9','CHdue_10',...
                    'alexfc7CNN','VGG19CNN','resnet50CNN','googleCNN'};    
                
descriptors      = {'HM',...
                    'TSM',...
                    'ZM_4_2','ZM_4_4','ZM_5_3','ZM_5_5','ZM_6_2','ZM_6_4','ZM_6_6','ZM_7_3','ZM_7_5','ZM_7_7','ZM_7_8','ZM_7_9','ZM_8_2',...                    'LMG_3','LMG_4','LMG_5','LMG_6','LMG_7','LMG_8','LMG_9','LMG_10',...
                    'LMG_3','LMG_4',...
                    'LMGS_3','LMGS_4',...
                    'CH_3','CH_4','CH_5',...
                    'CHdue_3','CHdue_4',...
                    'alexfc7CNN','VGG19CNN','resnet50CNN','googleCNN'}; 
                
%descriptors      =  {'HM','LMGS_3','LMGS_4','CHdue_3','CHdue_4','ZM_4_2','ZM_4_4','ZM_5_3','ZM_5_5','ZM_6_2'}; 
                
%descriptors      = {'CM','CM128','DM','SM','DMSM','GLCM','GLCMri','HM','HMCM','HMLBPri','ZM77','ZM77CM','ZM77LBPri','LM3','LM5CM','LM3LBP','LM3LBPri','LBP18'};
%descriptors      = {'HM','ZM77','LM3','GLCMri','LBP18','HMCM','HMLBPri','ZM77CM','ZM77LBPri','LM5CM','LM3LBPri',};

%descriptors      = {'LBP18', 'LBP116', 'LBP28', 'LBP216'};
%descriptors      = {'CLBP18', 'CLBP116', 'CLBP28', 'CLBP216'};
%descriptors      = {'DM','DMu','DMri','DM128','DM128ri','SM','SMu','SMri','SM128','SM128ri','DMSM','DMSMu','DMSMri','DMSM128','DMSM128ri', 'LBP18','CLBP18'};

descriptors = {'alexfc7CNN','VGG19CNN','resnet50CNN','googleCNN','VGG16CNN','resnet18CNN','resnet101CNN', ...
                'shufflenetCNN', 'squeezenetCNN', 'mobilenetv2CNN', 'inceptionv3CNN', 'seedNetCanadaCNN', 'seedNetCagliariCNN'};

descriptors = {'classic'};

if computePerformances == 1
    extractionTimeAll = zeros(numel(descriptors), numel(datasets));
    %Compute and store features for the angle 0°
    for dt = 1:numel(datasets)
        source = [sourcePath sep datasets{dt}];
        for dsc = 1:numel(descriptors)
            if contains(descriptors{dsc},'CNN') %%%CNN Features
                if contains(descriptors{dsc},'VGG16') %%%vgg16 CNN Features
                    convnet = vgg16;
                    disp('loaded vgg16 neural network')
                elseif contains(descriptors{dsc},'VGG19') %%%vgg19 CNN Features
                    convnet = vgg19;
                    disp('loaded vgg19 neural network')
                elseif contains(descriptors{dsc},'google') %%%google CNN Features
                    convnet = googlenet;
                    disp('loaded googlenet neural network')
                elseif contains(descriptors{dsc},'resnet18') %%%resnet18 CNN Features
                    convnet = resnet18;
                    disp('loaded resnet18 neural network')
                elseif contains(descriptors{dsc},'resnet50') %%%resnet50 CNN Features
                    convnet = resnet50;
                    disp('loaded resnet50 neural network')
                elseif contains(descriptors{dsc},'resnet101') %%%resnet101 CNN Features
                    convnet = resnet101;
                    disp('loaded resnet101 neural network')
                elseif contains(descriptors{dsc},'alex') %%%alexnet CNN Features
                    convnet = alexnet;
                    disp('loaded alexnet neural network')
                elseif contains(descriptors{dsc},'shufflenetCNN') %%%shufflenet CNN Features
                    convnet = shufflenet;
                    disp('loaded shufflenet neural network')
                elseif contains(descriptors{dsc},'squeezenetCNN') %%%squeezenet CNN Features
                    convnet = squeezenet;
                    disp('loaded squeezenet neural network')
                elseif contains(descriptors{dsc},'mobilenetv2CNN') %%%mobilenetv2 CNN Features
                    convnet = mobilenetv2;
                    disp('loaded mobilenetv2 neural network')
                elseif contains(descriptors{dsc},'inceptionv3CNN') %%%inceptionv3 CNN Features
                    convnet = inceptionv3;
                    disp('loaded inceptionv3 neural network')
                elseif contains(descriptors{dsc},'seedNetCanadaCNN') %%%seedNetCanada CNN Features
                    load('Nets/SeedNetCanada.mat');
                    disp('loaded seedNetCanada neural network')
                elseif contains(descriptors{dsc},'seedNetCagliariCNN') %%%seedNetCagliari CNN Features
                    load('Nets/SeedNetCagliari.mat');
                    disp('loaded seedNetCagliari neural network')
                end
                sizes = convnet.Layers(1).InputSize;
            end
            for gl = 1:numel(graylevel)
                for pp = 1:numel(prepro)
                    destination = [featsPath sep,...
                        datasets{dt} '___',...
                        descriptors{dsc} '___',...
                        num2str(graylevel(gl)) '___',...
                        prepro{pp} '.mat'];
                    %Check if file exists. If not, compute features.
                    if exist(destination) == 0
                        features = zeros(0,0);
                        extractionTime = [];
                        %images = getFileNames(source);
                        %images = sortImages(images);
                        fprintf('Computing/reading features: %s %s %s %s\n', datasets{dt}, descriptors{dsc}, num2str(graylevel(gl)), prepro{pp});
                        tic;
                        if contains(descriptors{dsc},'CNN') %%%CNN Features
                            imds = imageDatastore(fullfile(source), 'IncludeSubfolders',true);
                            imds.ReadFcn = @(filename)readAndPreprocessImage(filename,  prepro{pp}, [sizes(1) sizes(2)], graylevel(gl));
                            %imds.Files = images;
                            if contains(descriptors{dsc},'alexfc7') %%%alexnet Features                                                            
                                features = activations(convnet, imds, 'fc7', 'MiniBatchSize', 32);
                            elseif contains(descriptors{dsc},'VGG19') %%%VGG19 CNN Features
                                features = activations(convnet, imds, 'fc7', 'MiniBatchSize', 32);
                            elseif contains(descriptors{dsc},'VGG16') %%%VGG16 CNN Features
                                features = activations(convnet, imds, 'fc7', 'MiniBatchSize', 32);
                            elseif contains(descriptors{dsc},'google') %%%googlenet Features
                                features = activations(convnet, imds, 'loss3-classifier', 'MiniBatchSize', 32);
                            elseif contains(descriptors{dsc},'resnet50') %%%resnet50 Features
                                features = activations(convnet, imds, 'fc1000', 'MiniBatchSize', 32);
                            elseif contains(descriptors{dsc},'resnet101') %%%resnet101 Features
                                features = activations(convnet, imds, 'fc1000', 'MiniBatchSize', 32);
                            elseif contains(descriptors{dsc},'resnet18') %%%resnet18 Features
                                features = activations(convnet, imds, 'fc1000', 'MiniBatchSize', 32);
                            elseif contains(descriptors{dsc},'shufflenet') %%%shufflenet Features
                                features = activations(convnet, imds, 'node_202', 'MiniBatchSize', 32);
                            elseif contains(descriptors{dsc},'squeezenet') %%%shufflenet Features
                                features = activations(convnet, imds, 'pool10', 'MiniBatchSize', 32);
                            elseif contains(descriptors{dsc},'mobilenetv2') %%%shufflenet Features
                                features = activations(convnet, imds, 'Logits', 'MiniBatchSize', 32);
                            elseif contains(descriptors{dsc},'inceptionv3') %%%shufflenet Features
                                features = activations(convnet, imds, 'predictions', 'MiniBatchSize', 32);
                            elseif contains(descriptors{dsc},'seedNetCanadaCNN') %%%shufflenet Features
                                features = activations(convnet, imds, 'new_fc', 'MiniBatchSize', 32);
                            elseif contains(descriptors{dsc},'seedNetCagliariCNN') %%%shufflenet Features
                                features = activations(convnet, imds, 'new_fc', 'MiniBatchSize', 32);
                            end
                            features = squeeze(features);
                            features = features';
                        else
                            for i = 1:size(images,1)
                                img = imread(images{i});
                                fprintf('%s -- %s\n', descriptors{dsc}, 'gray', images{i});
                                features = [features; featureExtraction(img, descriptors{dsc}, 'gray', graylevel(gl), prepro{pp})'];
                            end
                        end
                        fprintf('Extracted features size: ');
                        size(features)
                        extractionTime = [extractionTime; toc];
                        extractionTimeAll(dsc,dt) = mean(extractionTime);
                        fprintf('--- DONE ---\n');
                        %Store features
                        save(destination, 'features'),
                    end
                end
            end
        end
    end
    if exist('extractionTimeAll.mat') == 0
        save('extractionTimeAll.mat','extractionTimeAll')
    end

    retrievalTimeAll = zeros(numel(descriptors), numel(datasets));
    %Compute features and Perform classification
    for dt = 1:numel(datasets)
        %Load labels
        load([labelsPath sep datasets{dt} '.mat'], 'labels');
        numReturnedImages = 1:length(labels)-1; % 214
        for dsc = 1:numel(descriptors)
            for gl = 1:numel(graylevel)
                for pp = 1:numel(prepro)
                    %Take train features from the 0-degree group
                    DBTrain = load([featsPath sep,...
                        datasets{dt} '___',...
                        descriptors{dsc} '___',...
                        num2str(graylevel(gl)), '___',...
                        prepro{pp}]);
                    DBTrain = DBTrain.features;
                    for sim = 1:numel(similarity)
                        for ni = 1:numel(numReturnedImages)               
                            for pop = 1:numel(postpro)
                                %Store retrieval results
                                destination = [retrievePath '/',...
                                    datasets{dt} '___',...
                                    descriptors{dsc} '___',...
                                    num2str(graylevel(gl)) '___',...
                                    prepro{pp} '___',...
                                    postpro{pop} '___',...
                                    similarity{sim} '___',...
                                    num2str(numReturnedImages(ni)) '.mat'];

                                if exist(destination) == 0
                                    fprintf('RETRIEVAL: %s %s %s %s %s %s %s\n', datasets{dt}, descriptors{dsc}, num2str(graylevel(gl)), num2str(numReturnedImages(ni)), similarity{sim}, prepro{pp}, postpro{pop});
                                    tic;
                                    [AP, AR, mAP] = EvaluateCrossRetrievalKFold(DBTrain, labels, numReturnedImages(ni), similarity{sim}, postpro{pop});
                                    retrievalTimeAll(dsc,dt,1) = toc;
                                    results = struct('AP', AP, 'AR', AR, 'mAP', mAP);
                                    save(destination, 'results'),
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    if exist('retrievalTimeAll.mat') == 0
        save('retrievalTimeAll.mat','retrievalTimeAll')
    end
end

%------------------------------------------------------------------------------------------------------------

if saveTables == 1
    headings =  ['\\documentclass[12pt,italian]{article}\n',...
        '\\usepackage{graphicx}\n',...
        '\\usepackage{longtable}\n',...
        '\\parskip 0.1in\n',...
        '\\oddsidemargin -1in\n',...
        '\\evensidemargin -1in\n',...
        '\\topmargin -0.5in\n',...
        '\\textwidth 6.8in\n',...
        '\\textheight 9.9in\n',...
        '\\usepackage{fancyhdr}\n',...
        '\\usepackage{booktabs}\n',...
        '\\usepackage{multirow}\n',...
        '\\usepackage{amsmath}\n',...
        '\\begin{document}\n',...
        '\\small\n' ];

    closing = '\\end{document}';
    %%salva i file Latex delle performances sia dei singoli dataset che un
    %%file generale con le performance medie
    %Collect and write results
    numReturnedImages = [1,10,20,50,100];  
    for dt = 1:numel(datasets)
        %Write results in a LaTeX table
        destination = [perfPath sep,...
            datasets{dt},...
            '.tex'];
        pFile = fopen(destination, 'w');
        fprintf(pFile, headings);
        for sim = 1:numel(similarity)
            for gl = 1:numel(graylevel)
                for pp = 1:numel(prepro)
                    for pop = 1:numel(postpro)                   
                        %Write table
                        fprintf(pFile, '\\begin{longtable}{l');
                        %fprintf(pFile, '\\begin{tabular}{l');
                        for ni = 1:(numel(numReturnedImages)*3 + 1)
                            fprintf(pFile, 'c');
                        end
                        fprintf(pFile, '}\n');
                        fprintf(pFile, '\\toprule\n');
                        %Heading
                        fprintf(pFile, '\\multicolumn{%d}{c}{Dataset=%s prepro= %s postpro= %s, gl= %s sim= %s} \\\\ \n', numel(numReturnedImages)*3+1, datasets{dt}, prepro{pp}, postpro{pop}, num2str(graylevel(gl)), similarity{sim});
                        fprintf(pFile, '\\toprule\n');
                        fprintf(pFile, 'Descriptor & \\multicolumn{%d}{c}{Windos size} \\\\ \n', numel(numReturnedImages)*3);
                        for ni = 1:numel(numReturnedImages)
                            fprintf(pFile, '& \\multicolumn{3}{c}{%s} ', num2str(numReturnedImages(ni)));
                        end
                        fprintf(pFile, '\\\\ \n');
                        for ni = 1:numel(numReturnedImages)
                            fprintf(pFile, '& AP & AR & mAP ');
                        end
                        fprintf(pFile, '\\\\ \n');
                        fprintf(pFile, '\\midrule\n');

                        %Data
                        for dsc = 1:numel(descriptors)
                            fprintf(pFile, '%s ', descriptors{dsc});
                            for ni = 1:numel(numReturnedImages)                     
                                %load retrieval results
                                destination = [retrievePath '/',...
                                    datasets{dt} '___',...
                                    descriptors{dsc} '___',...
                                    num2str(graylevel(gl)) '___',...
                                    prepro{pp} '___',...
                                    postpro{pop} '___',...
                                    similarity{sim} '___',...
                                    num2str(numReturnedImages(ni)) '.mat'];
                                load(destination, 'results');                       
                                fprintf(pFile, '& %4.1f ', 100*results.AP);
                                fprintf(pFile, '& %4.1f ', 100*results.AR);
                                fprintf(pFile, '& %4.1f ', 100*results.mAP);                      
                            end
                            fprintf(pFile, '\\\\ \n');
                        end
                        fprintf(pFile, '\\bottomrule\n');
                        fprintf(pFile, '\\end{longtable} \n');
                        fprintf(pFile, '\n \\pagebreak \n');
                    end
                end
            end
        end
        if pFile ~= -1
            fprintf(pFile, closing);
            fclose(pFile);
        end
    end
end


if savePlotsVariingPrePro == 1    
    
    similarity = {'euclidean'};
    graylevel = [256];
    prepro = ["none", "imu8", "imu8+s", "immatu8", "immatu8+s", "map"];
    
    type = {'\addplot[color=blue, mark=star, dashdotted]',...
        '\addplot[color=red, mark=x, dashdotted]',...
        '\addplot[color=green, mark=+, dashdotted]',...
        '\addplot[color=black, mark=|, dashdotted]',...
        '\addplot[color=violet, mark=triangle]',...
        '\addplot[color=cyan, mark=diamond]',...
        '\addplot[color=gray,mark=square]',...
        '\addplot[color=lime,mark=pentagon]',...
        '\addplot[color=magenta, mark=o]',...
        '\addplot[color=orange, mark=triangle*, dashed]',...
        '\addplot[color=teal, mark=diamond*, dashed]',...
        '\addplot[color=brown, mark=square*, dashed]',...
        '\addplot[color=purple, mark=pentagon*, dashed]',...
        '\addplot[color=yellow, mark=*, dashdotted]',...
        '\addplot[color=peach, mark=square]',...
        '\addplot[color=tan, mark=diamond, dashdotted]',...
        '\addplot[color=orchid, mark=+, dashed]',...
        '\addplot[color=aquamarine, mark=|, dashdotted]',...
        '\addplot[color=seagreen, mark=x]'};
    
    headings =  ['\\documentclass[12pt,italian]{article}\n',...
        '\\usepackage{graphicx}\n',...
        '\\usepackage{longtable}\n',...
        '\\parskip 0.1in\n',...
        '\\oddsidemargin -1in\n',...
        '\\evensidemargin -1in\n',...
        '\\topmargin -0.5in\n',...
        '\\textwidth 6.8in\n',...
        '\\textheight 9.9in\n',...
        '\\usepackage{fancyhdr}\n',...
        '\\usepackage{booktabs}\n',...
        '\\usepackage{multirow}\n',...  
        '\\usepackage{tikz}\n',...
        '\\usepackage{pgfplotstable}\n',...
        '\\usepackage{pgfplots}\n',...
        '\\usepgfplotslibrary{groupplots}\n',...
        '\\pgfplotsset{compat=newest}\n',...
        '\\usepackage{amsmath}\n',...
        '\\begin{document}\n'];
    
    metrics = {'Precision', 'Recall'};
    
    %write latex plots using precision metric
    for me = 1:numel(metrics)
        if strcmp(metrics{me},'Precision')
            destination = [perfPath '/Plots_precision.tex'];
        elseif strcmp(metrics{me},'Recall')
            destination = [perfPath '/Plots_recall.tex'];
        end
            
        pFile = fopen(destination, 'w');
        fprintf(pFile, headings);

        for dt = 1:numel(datasets)
            %Load labels
            load([labelsPath sep datasets{dt}], 'labels');
            numReturnedImages = 1:5:length(labels)-1;
            for gl = 1:numel(graylevel)
                for dsc = 1:numel(descriptors)
                    for sim = 1:numel(similarity)
                        for pop = 1:numel(postpro)
                            fprintf(pFile, '\\begin{figure}\n');
                            fprintf(pFile,'\\begin{center}\n');
                            fprintf(pFile,'\\begin{tikzpicture}\n');
                            fprintf(pFile,'\\begin{groupplot}[ group style={group size=1 by 1, vertical sep= 0.4cm, horizontal sep=0.6cm}, width=20cm, height=14cm]\n');
                            fprintf(pFile, '\\nextgroupplot[ \n');
                            fprintf(pFile, 'title={Dataset= %s, gl= %s, descriptor= %s, simi= %s, postpro= %s}, \n', datasets{dt}, num2str(graylevel(gl)), descriptors{dsc}, similarity{sim}, postpro{pop});
                            fprintf(pFile, 'xlabel={Window size}, \n');
                            if strcmp(metrics{me},'Precision')
                                fprintf(pFile, 'ylabel={Precision}, \n');
                            elseif strcmp(metrics{me},'Recall')
                                fprintf(pFile, 'ylabel={Recall}, \n');
                            end
                            fprintf(pFile, 'legend style = { column sep = 5pt, legend columns = 3, legend to name = grouplegend}, \n');
                            fprintf(pFile, ['xmin=1, xmax=' num2str(numel(labels)) ', \n']);
                            fprintf(pFile, 'ymin=0, ymax=1, \n');
                            fprintf(pFile, 'ymajorgrids=true, \n');
                            fprintf(pFile, 'xmajorgrids=true, \n');
                            fprintf(pFile, 'grid style=dashed] \n');
                            for pp = 1:numel(prepro)
                                fprintf(pFile, '\\addlegendentry{%s}  \n', prepro{pp});
                                fprintf(pFile, ' %s \n', type{pp});
                                fprintf(pFile, ' coordinates{');
                                for ni = 1:numel(numReturnedImages)    
                                    %Store retrieval results
                                    destination = [retrievePath '/',...
                                        datasets{dt} '___',...
                                        descriptors{dsc} '___',...
                                        num2str(graylevel(gl)) '___',...
                                        prepro{pp} '___',...
                                        postpro{pop} '___',...
                                        similarity{sim} '___',...
                                        num2str(numReturnedImages(ni)) '.mat'];
                                    load(destination, 'results');   
                                    if strcmp(metrics{me},'Precision')
                                        fprintf(pFile, '(%d, %2.2f)', numReturnedImages(ni), results.AP);
                                    elseif strcmp(metrics{me},'Recall')
                                        fprintf(pFile, '(%d, %2.2f)', numReturnedImages(ni), results.AR);
                                    end
                                end
                                fprintf(pFile, '};\n ');
                            end
                            closing =  ['\\end{groupplot}\n',...
                                '\\end{tikzpicture}\n',...
                                '\\ref{grouplegend}\n',...
                                '\\caption{Precision when the windows size takes the value $k=1-'...
                                num2str(numReturnedImages(end)),...
                                '$.}\n', ...
                                '\\label{fig:precision_comparison}\n',...
                                '\\end{center}\n',...
                                '\\end{figure}\n'];
                            fprintf(pFile, closing);
                        end
                    end
                end
            end
        end
        fprintf(pFile, '\\end{document}');
        fclose(pFile);
    end
end

if savePlotsVariingDesc == 1    
    
    %similarity = {'euclidean'; 'cityblock'; 'minkowski'; 'chebychev'; 'cosine'; 'correlation'; 'spearman'; 'camberra'; 'D1'; 'chi2'; 'KLDiv'};
    similarity = {'euclidean'; 'D1'};
    type = {'\addplot[color=blue, mark=star, dashdotted]',...
        '\addplot[color=red, mark=x, dashdotted]',...
        '\addplot[color=green, mark=+, dashdotted]',...
        '\addplot[color=black, mark=|, dashdotted]',...
        '\addplot[color=violet, mark=triangle]',...
        '\addplot[color=cyan, mark=diamond]',...
        '\addplot[color=gray,mark=square]',...
        '\addplot[color=lime,mark=pentagon]',...
        '\addplot[color=magenta, mark=o]',...
        '\addplot[color=orange, mark=triangle*, dashed]',...
        '\addplot[color=teal, mark=diamond*, dashed]',...
        '\addplot[color=brown, mark=square*, dashed]',...
        '\addplot[color=purple, mark=pentagon*, dashed]',...
        '\addplot[color=yellow, mark=*, dashdotted]',...
        '\addplot[color=peach, mark=square]',...
        '\addplot[color=tan, mark=diamond, dashdotted]',...
        '\addplot[color=orchid, mark=+, dashed]',...
        '\addplot[color=aquamarine, mark=|, dashdotted]',...
        '\addplot[color=seagreen, mark=x]'};
    
    headings =  ['\\documentclass[12pt,italian]{article}\n',...
        '\\usepackage{graphicx}\n',...
        '\\usepackage{longtable}\n',...
        '\\parskip 0.1in\n',...
        '\\oddsidemargin -1in\n',...
        '\\evensidemargin -1in\n',...
        '\\topmargin -0.5in\n',...
        '\\textwidth 6.8in\n',...
        '\\textheight 9.9in\n',...
        '\\usepackage{fancyhdr}\n',...
        '\\usepackage{booktabs}\n',...
        '\\usepackage{multirow}\n',...  
        '\\usepackage{tikz}\n',...
        '\\usepackage{pgfplotstable}\n',...
        '\\usepackage{pgfplots}\n',...
        '\\usepgfplotslibrary{groupplots}\n',...
        '\\pgfplotsset{compat=newest}\n',...
        '\\usepackage{amsmath}\n',...
        '\\begin{document}\n'];
    
    metrics = {'Precision', 'Recall'};
    
    %write latex plots using precision metric
    for me = 1:numel(metrics)
        if strcmp(metrics{me},'Precision')
            destination = [perfPath '/Plots_precision.tex'];
        elseif strcmp(metrics{me},'Recall')
            destination = [perfPath '/Plots_recall.tex'];
        end
            
        pFile = fopen(destination, 'w');
        fprintf(pFile, headings);

        for dt = 1:numel(datasets)
            %Load labels
            load([labelsPath sep datasets{dt}], 'labels');
            numReturnedImages = 1:5:length(labels)-1;
            for gl = 1:numel(graylevel)
                for pp = 1:numel(prepro)
                    for sim = 1:numel(similarity)
                        for pop = 1:numel(postpro)
                            fprintf(pFile, '\\begin{figure}\n');
                            fprintf(pFile,'\\begin{center}\n');
                            fprintf(pFile,'\\begin{tikzpicture}\n');
                            fprintf(pFile,'\\begin{groupplot}[ group style={group size=1 by 1, vertical sep= 0.4cm, horizontal sep=0.6cm}, width=20cm, height=14cm]\n');
                            fprintf(pFile, '\\nextgroupplot[ \n');
                            fprintf(pFile, 'title={Dataset= %s, gl= %s, prepro= %s, simi= %s, postpro= %s}, \n', datasets{dt}, num2str(graylevel(gl)), prepro{pp}, similarity{sim}, postpro{pop});
                            fprintf(pFile, 'xlabel={Window size}, \n');
                            if strcmp(metrics{me},'Precision')
                                fprintf(pFile, 'ylabel={Precision}, \n');
                            elseif strcmp(metrics{me},'Recall')
                                fprintf(pFile, 'ylabel={Recall}, \n');
                            end
                            fprintf(pFile, 'legend style = { column sep = 5pt, legend columns = 3, legend to name = grouplegend}, \n');
                            fprintf(pFile, ['xmin=1, xmax=' num2str(numel(labels)) ', \n']);
                            fprintf(pFile, 'ymin=0, ymax=1, \n');
                            fprintf(pFile, 'ymajorgrids=true, \n');
                            fprintf(pFile, 'xmajorgrids=true, \n');
                            fprintf(pFile, 'grid style=dashed] \n');
                            for dsc = 1:numel(descriptors)
                                fprintf(pFile, '\\addlegendentry{%s}  \n', descriptors{dsc});
                                fprintf(pFile, ' %s \n', type{dsc});
                                fprintf(pFile, ' coordinates{');
                                for ni = 1:numel(numReturnedImages)    
                                    %Store retrieval results
                                    destination = [retrievePath '/',...
                                        datasets{dt} '___',...
                                        descriptors{dsc} '___',...
                                        num2str(graylevel(gl)) '___',...
                                        prepro{pp} '___',...
                                        postpro{pop} '___',...
                                        similarity{sim} '___',...
                                        num2str(numReturnedImages(ni)) '.mat'];
                                    load(destination, 'results');   
                                    if strcmp(metrics{me},'Precision')
                                        fprintf(pFile, '(%d, %2.2f)', numReturnedImages(ni), results.AP);
                                    elseif strcmp(metrics{me},'Recall')
                                        fprintf(pFile, '(%d, %2.2f)', numReturnedImages(ni), results.AR);
                                    end
                                end
                                fprintf(pFile, '};\n ');
                            end
                            closing =  ['\\end{groupplot}\n',...
                                '\\end{tikzpicture}\n',...
                                '\\ref{grouplegend}\n',...
                                '\\caption{Precision when the windows size takes the value $k=1-'...
                                num2str(numReturnedImages(end)),...
                                '$.}\n', ...
                                '\\label{fig:precision_comparison}\n',...
                                '\\end{center}\n',...
                                '\\end{figure}\n'];
                            fprintf(pFile, closing);
                        end
                    end
                end
            end
        end
        fprintf(pFile, '\\end{document}');
        fclose(pFile);
    end
end