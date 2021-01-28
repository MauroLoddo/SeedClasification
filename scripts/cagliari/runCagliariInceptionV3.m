%% Initialization
clear;
close all;
clc;

addpath(genpath('/home/server/MATLAB/topics/SeedsClassification/SeedClasification'));

%% Local paths / Server paths management
datasetpath = '../datasets/Cagliari';
modelspath = 'models/cagliari';
modelName = "inceptionv3_";


%% Classes managements
family1 = 'Amorpha fruticosa';
family2 = 'Anagyris foetida';
family3 = 'Anthyllis barba-jovis';
family4 = 'Anthyllis cytisoides';
family5 = 'Astragalus glycyphyllos';
family6 = 'Calicotome villosa';
family7 = 'Caragana arborescens';
family8 = 'Ceratonia siliqua';
family9 = 'Colutea arborescens';
family10 = 'Cytisus purgans';
family11 = 'Cytisus scoparius';
family12 = 'Dorycnium pentaphyllum';
family13 = 'Dorycnium rectum';
family14 = 'Hedysarum coronarium';
family15 = 'Lathyrus aphaca';
family16 = 'Lathyrus ochrus';
family17 = 'Medicago sativa';
family18 = 'Melilotus officinalis';
family19 = 'Pisum sativum subsp. elatius';
family20 = 'Senna alexandrina';
family21 = 'Spartium junceum';
family22 = 'Trifolium angustifolium';
family23 = 'Vicia faba';



%% =============== Part 1: Loading Data ================
fprintf('Loading Data \n');

% n is the number of types of images
nClass = 23;

im = imageDatastore(datasetpath,'IncludeSubfolders',true,'LabelSource','foldernames');
% Resize the images to the input size of the net
im.ReadFcn = @(loc)imresize(imread(loc),[224,224]); %function readFcn outputs the corrisponding image

%Codice per estrarre una immagine casuale per ogni classe e mostrarle a
%video
for i=1:nClass
    switch i
        case 1
            d=strcat(datasetpath, '/');
            d=strcat(d, family1);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img1=imread(imName);
        case 2
            d=strcat(datasetpath, '/');
            d=strcat(d, family2);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img2=imread(imName);
        case 3
            d=strcat(datasetpath, '/');
            d=strcat(d, family3);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img3=imread(imName);
        case 4
            d=strcat(datasetpath, '/');
            d=strcat(d, family4);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img4=imread(imName);
        case 5
            d=strcat(datasetpath, '/');
            d=strcat(d, family5);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img5=imread(imName);
        case 6
            d=strcat(datasetpath, '/');
            d=strcat(d, family6);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img6=imread(imName);
        case 7
            d=strcat(datasetpath, '/');
            d=strcat(d, family7);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img7=imread(imName);
         case 8
            d=strcat(datasetpath, '/');
            d=strcat(d, family8);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img8=imread(imName);
         case 9
            d=strcat(datasetpath, '/');
            d=strcat(d, family9);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img9=imread(imName);
         case 10
            d=strcat(datasetpath, '/');
            d=strcat(d, family10);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img10=imread(imName);
         case 11
            d=strcat(datasetpath, '/');
            d=strcat(d, family11);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img11=imread(imName);
         case 12
            d=strcat(datasetpath, '/');
            d=strcat(d, family12);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img12=imread(imName);
         case 13
            d=strcat(datasetpath, '/');
            d=strcat(d, family13);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img13=imread(imName);
         case 14
            d=strcat(datasetpath, '/');
            d=strcat(d, family14);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img14=imread(imName);
         case 15
            d=strcat(datasetpath, '/');
            d=strcat(d, family15);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img15=imread(imName);
         case 16
            d=strcat(datasetpath, '/');
            d=strcat(d, family16);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img16=imread(imName);
         case 17
            d=strcat(datasetpath, '/');
            d=strcat(d, family17);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img17=imread(imName);
         case 18
            d=strcat(datasetpath, '/');
            d=strcat(d, family18);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img18=imread(imName);
         case 19
            d=strcat(datasetpath, '/');
            d=strcat(d, family19);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img19=imread(imName);
         case 20
            d=strcat(datasetpath, '/');
            d=strcat(d, family20);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img20=imread(imName);
         case 21
            d=strcat(datasetpath, '/');
            d=strcat(d, family21);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img21=imread(imName);
         case 22
            d=strcat(datasetpath, '/');
            d=strcat(d, family22);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, '461_103.jpg');%f(idx).name);
            img22=imread(imName);
         case 23
            d=strcat(datasetpath, '/');
            d=strcat(d, family23);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img23=imread(imName);
    end
end


%% =============== Part 2: Training Data ================

net = inceptionv3();

[Train, Test, Validations] = splitEachLabel(im,0.8,0.1,0.10,'randomized'); 

%Augmentation
imageAugmenter = imageDataAugmenter('RandRotation',[-90,90],...
    'RandXTranslation',[-20 20],'RandYTranslation',[-20 20],...
    'RandXReflection',true,'RandYReflection',true);

Train = augmentedImageDatastore([299,299], Train,'DataAugmentation',imageAugmenter);
Validations = augmentedImageDatastore([299,299], Validations, 'DataAugmentation',imageAugmenter);


ly = net.Layers;
lgraph = layerGraph(net);
[learnableLayer,classLayer] = findLayersToReplace(lgraph);

fc = fullyConnectedLayer(nClass, 'Name','fullyConnected');
cl = classificationLayer('Name','output');
lgraph = replaceLayer(lgraph,'predictions',fc);
lgraph = replaceLayer(lgraph,'ClassificationLayer_predictions',cl);


learning_rate = 0.0001; %Più è basso più tempo impiega e più è preciso
mbs = 16;
ep = 100;
opts = trainingOptions( "adam",...
                        "InitialLearnRate", learning_rate,...
                        'MaxEpochs',ep,...
                        'MiniBatchSize',mbs,...
                        'Plots','training-progress',...
                        'ValidationData', Validations,...
                        'ValidationFrequency', 5); 
[newnet,info] = trainNetwork(Train, lgraph, opts);



%% =============== Part 3: Predicting accuracy for Test Set ================
fprintf('Predicting accuracy for Test Set \n');
[predict,scores] = classify(newnet,Test); %la funzione classify predice le etichette da assegnare alle determinate immagini, restituisce anche i punteggi di classificazione corrispondenti alle etichette di classe utilizzando una delle sintassi precedenti.
names = Test.Labels;
pred = (predict==names);
s = size(pred);
acc = sum(pred)/s(1);
fprintf('The accuracy of the test set is %f \n',acc*100);

confusionMatrix = confusionchart(names, predict);
confusionMatrix.ColumnSummary = 'column-normalized';
confusionMatrix.RowSummary = 'row-normalized';

cm = confusionmat(names, predict);
%Sensitivity
for i =1:size(cm,1)
    Sensitivity(i)=cm(i,i)/sum(cm(i,:));
end
Sensitivity(isnan(Sensitivity))=[];

Sensitivity=(sum(Sensitivity)/size(cm,1));
%Specificity
for i =1:size(cm,1)
    Specificity(i)=cm(i,i)/sum(cm(:,i));
end
Specificity=sum(Specificity)/size(cm,1);

fprintf('The specificity of the test set is %f \n',Specificity*100);
fprintf('The sensitivity of the test set is %f \n',Sensitivity*100);


save(fullfile(modelspath, strcat(modelName, num2str(ep), "ep_", num2str(mbs), "mbs")), "newnet");
save(fullfile(modelspath, strcat(modelName, num2str(ep), "ep_", num2str(mbs), "mbs", "_cm")), "confusionMatrix");

