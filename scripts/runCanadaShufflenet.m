%% Initialization
clear;
close all;
clc;

addpath(genpath('/home/server/MATLAB/topics/SeedsClassification/SeedClasification'));

%% Local paths / Server paths management
datasetpath = '../datasets/Canada';
modelspath = 'models/canada';
modelName = "shufflenet";

%% Classes managements
firstFamily = 'Amaranthaceae';
secondFamily = 'Apiaceae';
thirdFamily = 'Asteraceae';
fourthFamily = 'Brassicaceae';
fifthFamily = 'Plantaginaceae';
sixthFamily = 'Solanaceae';


%% =============== Part 1: Loading Data ================
fprintf('Loading Data \n');

% n is the number of types of images
nClass = 6;

im = imageDatastore(datasetpath,'IncludeSubfolders',true,'LabelSource','foldernames');
% Resize the images to the input size of the net
im.ReadFcn = @(loc)imresize(imread(loc),[224,224]); %function readFcn outputs the corrisponding image

%Codice per estrarre una immagine casuale per ogni classe e mostrarle a
%video
for i=1:nClass
    switch i
        case 1
            d=strcat(datasetpath, '/');
            d=strcat(d, firstFamily);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img1=imread(imName);
        case 2
            d=strcat(datasetpath, '/');
            d=strcat(d, secondFamily);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img2=imread(imName);
        case 3
            d=strcat(datasetpath, '/');
            d=strcat(d, thirdFamily);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img3=imread(imName);
        case 4
            d=strcat(datasetpath, '/');
            d=strcat(d, fourthFamily);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img4=imread(imName);
        case 5
            d=strcat(datasetpath, '/');
            d=strcat(d, fifthFamily);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img5=imread(imName);
        case 6
            d=strcat(datasetpath, '/');
            d=strcat(d, sixthFamily);
            f=dir([d '/*.jpg']);
            n=length(f);
            idx=randi(n);
            imName= strcat(d, '/');
            imName= strcat(imName, f(idx).name);
            img6=imread(imName);
    end
end


%% =============== Part 2: Training Data ================

net = shufflenet;

[Train, Test, Validations] = splitEachLabel(im,0.5,0.4,0.1,'randomized');
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
lgraph = replaceLayer(lgraph,'node_202',fc);
lgraph = replaceLayer(lgraph,'ClassificationLayer_node_203',cl);

% options for training the net if your newnet performance is low decrease
% the learning_rate
learning_rate = 0.0001; %Più è basso più tempo impiega e più è preciso
mbs = 64;
ep = 100;
opts = trainingOptions( "adam",...
                        "InitialLearnRate", learning_rate,...
                        'MaxEpochs',ep,...
                        'MiniBatchSize',mbs,...
                        'Plots','training-progress',...
                        'ValidationData', Validations,...
                        'ValidationFrequency', 5);

[newnet,info] = trainNetwork(Train, lgraph, opts); % addestra la rete prendendo in input: immagini(quelle scelte per il training), i layers e le opzioni; viene restituita la rete e le informazioni


%% =============== Part 3: Predicting accuracy for Test Set ================
fprintf('Predicting accuracy for Test Set \n');
[predict,scores] = classify(newnet,Test); 
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
