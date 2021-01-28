%% Initialization
clear;
close all;
clc;

addpath(genpath('/home/server/MATLAB/topics/SeedsClassification/SeedClasification'));

%% Local paths / Server paths management
datasetpath = '../datasets/Cagliari';
modelspath = 'models';


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

position = [1 1];
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
            img1=insertText(img1, position, family1,'FontSize',10,'BoxColor', 'white', 'TextColor', 'black', 'BoxOpacity', 0.8);
        case 2
            d=strcat(datasetpath, '/');
            d=strcat(d, family2);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img2=imread(imName);
            img2=insertText(img2, position, family2,'FontSize',18,'BoxColor', 'white', 'TextColor', 'black', 'BoxOpacity', 0.8);
        case 3
            d=strcat(datasetpath, '/');
            d=strcat(d, family3);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img3=imread(imName);
            img3=insertText(img3, position, family3,'FontSize',5,'BoxColor', 'white', 'TextColor', 'black', 'BoxOpacity', 0.8);
        case 4
            d=strcat(datasetpath, '/');
            d=strcat(d, family4);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img4=imread(imName);
            img4=insertText(img4, position, family4,'FontSize',18,'BoxColor', 'white', 'TextColor', 'black', 'BoxOpacity', 0.8);
        case 5
            d=strcat(datasetpath, '/');
            d=strcat(d, family5);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img5=imread(imName);
            img5=insertText(img5, position, family5,'FontSize',18,'BoxColor', 'white', 'TextColor', 'black', 'BoxOpacity', 0.8);
        case 6
            d=strcat(datasetpath, '/');
            d=strcat(d, family6);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img6=imread(imName);
            img6=insertText(img6, position, family6,'FontSize',18,'BoxColor', 'white', 'TextColor', 'black', 'BoxOpacity', 0.8);
        case 7
            d=strcat(datasetpath, '/');
            d=strcat(d, family7);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img7=imread(imName);
            img7=insertText(img7, position, family7,'FontSize',18,'BoxColor', 'white', 'TextColor', 'black', 'BoxOpacity', 0.8);
         case 8
            d=strcat(datasetpath, '/');
            d=strcat(d, family8);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img8=imread(imName);
            img8=insertText(img8, position, family8,'FontSize',18,'BoxColor', 'white', 'TextColor', 'black', 'BoxOpacity', 0.8);
         case 9
            d=strcat(datasetpath, '/');
            d=strcat(d, family9);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img9=imread(imName);
            img9=insertText(img9, position, family9,'FontSize',18,'BoxColor', 'white', 'TextColor', 'black', 'BoxOpacity', 0.8);
         case 10
            d=strcat(datasetpath, '/');
            d=strcat(d, family10);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img10=imread(imName);
            img10=insertText(img10, position, family10,'FontSize',18,'BoxColor', 'white', 'TextColor', 'black', 'BoxOpacity', 0.8);
         case 11
            d=strcat(datasetpath, '/');
            d=strcat(d, family11);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img11=imread(imName);
            img11=insertText(img11, position, family11,'FontSize',18,'BoxColor', 'white', 'TextColor', 'black', 'BoxOpacity', 0.8);
         case 12
            d=strcat(datasetpath, '/');
            d=strcat(d, family12);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img12=imread(imName);
            img12=insertText(img12, position, family12,'FontSize',18,'BoxColor', 'white', 'TextColor', 'black', 'BoxOpacity', 0.8);
         case 13
            d=strcat(datasetpath, '/');
            d=strcat(d, family13);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img13=imread(imName);
            img13=insertText(img13, position, family13,'FontSize',18,'BoxColor', 'white', 'TextColor', 'black', 'BoxOpacity', 0.8);
         case 14
            d=strcat(datasetpath, '/');
            d=strcat(d, family14);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img14=imread(imName);
            img14=insertText(img14, position, family14,'FontSize',18,'BoxColor', 'white', 'TextColor', 'black', 'BoxOpacity', 0.8);
         case 15
            d=strcat(datasetpath, '/');
            d=strcat(d, family15);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img15=imread(imName);
            img15=insertText(img15, position, family15,'FontSize',18,'BoxColor', 'white', 'TextColor', 'black', 'BoxOpacity', 0.8);
         case 16
            d=strcat(datasetpath, '/');
            d=strcat(d, family16);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img16=imread(imName);
            img16=insertText(img16, position, family16,'FontSize',18,'BoxColor', 'white', 'TextColor', 'black', 'BoxOpacity', 0.8);
         case 17
            d=strcat(datasetpath, '/');
            d=strcat(d, family17);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img17=imread(imName);
            img17=insertText(img17, position, family17,'FontSize',18,'BoxColor', 'white', 'TextColor', 'black', 'BoxOpacity', 0.8);
         case 18
            d=strcat(datasetpath, '/');
            d=strcat(d, family18);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img18=imread(imName);
            img18=insertText(img18, position, family18,'FontSize',18,'BoxColor', 'white', 'TextColor', 'black', 'BoxOpacity', 0.8);
         case 19
            d=strcat(datasetpath, '/');
            d=strcat(d, family19);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img19=imread(imName);
            img19=insertText(img19, position, family19,'FontSize',18,'BoxColor', 'white', 'TextColor', 'black', 'BoxOpacity', 0.8);
         case 20
            d=strcat(datasetpath, '/');
            d=strcat(d, family20);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img20=imread(imName);
            img20=insertText(img20, position, family20,'FontSize',18,'BoxColor', 'white', 'TextColor', 'black', 'BoxOpacity', 0.8);
         case 21
            d=strcat(datasetpath, '/');
            d=strcat(d, family21);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img21=imread(imName);
            img21=insertText(img21, position, family21,'FontSize',18,'BoxColor', 'white', 'TextColor', 'black', 'BoxOpacity', 0.8);
         case 22
            d=strcat(datasetpath, '/');
            d=strcat(d, family22);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img22=imread(imName);
            img22=insertText(img22, position, family22,'FontSize',3,'BoxColor', 'white', 'TextColor', 'black', 'BoxOpacity', 0.8);
         case 23
            d=strcat(datasetpath, '/');
            d=strcat(d, family23);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img23=imread(imName);
            img23=insertText(img23, position, family23,'FontSize',18,'BoxColor', 'white', 'TextColor', 'black', 'BoxOpacity', 0.8);
    end
end
    multi = {img1,img2,img3,img4,img5,img6,img7,img8,img9,img10,img11,img12,img13,img14,img15,img16,img17,img18,img19,img20,img21,img22,img23};
    montage(multi);
%% =============== Part 2: Training Data ================

net = googlenet();

[Train, Test, Validations] = splitEachLabel(im,0.8,0.1,0.10,'randomized');

%Augmentation
imageAugmenter = imageDataAugmenter('RandRotation',[-90,90],...
    'RandXTranslation',[-20 20],'RandYTranslation',[-20 20],...
    'RandXReflection',true,'RandYReflection',true);

Train = augmentedImageDatastore([224 224], Train,'DataAugmentation',imageAugmenter);
Validations = augmentedImageDatastore([224 224], Validations, 'DataAugmentation',imageAugmenter);


ly = net.Layers;
lgraph = layerGraph(net);
[learnableLayer,classLayer] = findLayersToReplace(lgraph);

fc = fullyConnectedLayer(nClass, 'Name','fullyConnected');
cl = classificationLayer('Name','output');
lgraph = replaceLayer(lgraph,'loss3-classifier',fc);
lgraph = replaceLayer(lgraph,'output',cl);


% options for training the net if your newnet performance is low decrease
% the learning_rate
learning_rate = 0.0001; %Più è basso più tempo impiega e più è preciso
opts = trainingOptions("adam","InitialLearnRate",learning_rate,'MaxEpochs',50,...
    'MiniBatchSize',64,'Plots','training-progress',...
    'ValidationData', Validations, 'ValidationFrequency', 5); %adam è il tipo di optimizer utilizzato/le epoche sono il passaggio completo dell'algoritmo di addestramento sull'intero set/mini-batch è un sottoinsieme del set di addestramento utilizzato per valutare il gradiente della funzione di perdita/minore è il valore della validation frequency, più spesso verrà validata la rete
[newnet,info] = trainNetwork(Train, lgraph, opts); % addestra la rete prendendo in input: immagini(quelle scelte per il training), i layers e le opzioni; viene restituita la rete e le informazioni
save(fullfile(modelspath, "googlenet_model"), "newnet");

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
save(fullfile(modelspath, "googlenet_conf"), "confusionMatrix");

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
