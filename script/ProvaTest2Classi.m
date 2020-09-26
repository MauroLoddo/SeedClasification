%% Consigli sparsi:
% 1) non inserire path assoluti sparsi in giro per il codice ma usa un
% punto unico di accesso al dataset, impostandoti una variabile iniziale
% 2) dovremmo prevedere un modo per distinguere i path locali del tuo pc e
% i path del server dove posso lanciare gli esperimenti. Lo inizio a
% impostare qui. 
% 3) non so dove abbia preso questo codice però lo scheletro c'è e va bene.
% Potresti evitare l'interazione con l'utente, non ci servirà quando
% lanceremo gli esperimenti grossi, per ora può andare bene per
% interagirci.
% 4) Come detto, il codice è predisposto bene ma è essenziale in questa
% fase iniziale che tu capisca cosa stai andando a fare, quasi in ogni riga
% di codice. Per farlo, il mio consiglio è quello di analizzarti bene a
% fondo questo file che hai creato e segnalarmi qualsiasi cosa tu non
% conosca o abbia capito.
% 5) Una cosa importante da aggiungere sarà il validation set. Per ora ho
% notato che usi solo train e test set ma ora che ci addentriamo negli
% esperimenti devi lavorare usando lo split a 3: train, validation e test set.
% 6) L'output che tipicamente vogliamo avere e salvare è l'accuratezza
% della rete e la matrice di confusione generata dall'esperimento. Per ora
% mi sta bene che lavori su singole immagini per capirci qualcosa in più 
% ma quando verificheremo il funzionamento dell'intero modello, 
% andremo a testare l'intero test set.
% 7. Suggerimenti sparsi: so che sperimentare in questo modo può portare a
% utilizzare magic numbers sparsi in giro ma il mio consiglio è: evitali
% come la peste e rendi il codice leggibile, anche quando si tratta di
% impostare parametri "al volo", come il numero di classi di un livello, la
% mini batch size e così via.

%% Initialization
clear; 
close all; 
clc;

%% Local paths / Server paths management
if ismac
    datasetpath = '/Users/mauroloddo/Documents/MATLAB/SeedClasification/Tests';
else %TODO
    datasetpath = '/home/server/TODO';
end


%% Classes managements
firstFamily = 'Amaranthaceae';
secondFamily = 'Apiaceae';
thirdFamily = 'Asteraceae';
fourthFamily = 'Brassicaceae';


%% =============== Part 1: Loading Data ================
fprintf('Loading Data \n');

% n is the number of types of images
n = 4;

im = imageDatastore(datasetpath,'IncludeSubfolders',true,'LabelSource','foldernames');
% Resize the images to the input size of the net
im.ReadFcn = @(loc)imresize(imread(loc),[227,227]); %function readFcn outputs the corrisponding image
[Train, Validations, Test] = splitEachLabel(im,0.8,0.1); 

%fprintf('Program paused. \nYou can press stop button manually on tranining plot(on top right corner besides number of iterations) once accuracy reaches upto desired level. Press enter to continue.\n');
%pause;

%% =============== Part 2: Training Data ================
fc = fullyConnectedLayer(n);
net = alexnet;
ly = net.Layers;
ly(23) = fc;
cl = classificationLayer;
ly(25) = cl; 
% options for training the net if your newnet performance is low decrease
% the learning_rate
learning_rate = 0.0001; %Più è basso più tempo impiega e più è preciso
opts = trainingOptions("adam","InitialLearnRate",learning_rate,'MaxEpochs',20,'MiniBatchSize',32,'Plots','training-progress', 'ValidationData', Validations, 'ValidationFrequency', 5); %adam è il tipo di optimizer utilizzato/le epoche sono il passaggio completo dell'algoritmo di addestramento sull'intero set/mini-batch è un sottoinsieme del set di addestramento utilizzato per valutare il gradiente della funzione di perdita/minore è il valore della validation frequency, più spesso verrà validata la rete
[newnet,info] = trainNetwork(Train, ly, opts); % addestra la rete prendendo in input: immagini(quelle scelte per il training), i layers e le opzioni; viene restituita la rete e le informazioni
%fprintf('Program paused. Press enter to continue.\n');
%pause;
 
 
%% =============== Part 3: Predicting accuracy for Test Set ================
fprintf('Predicting accuracy for Test Set \n');
[predict,scores] = classify(newnet,Test); %la funzione classify predice le etichette da assegnare alle determinate immagini, restituisce anche i punteggi di classificazione corrispondenti alle etichette di classe utilizzando una delle sintassi precedenti.
names = Test.Labels;
pred = (predict==names);
s = size(pred);
acc = sum(pred)/s(1);
fprintf('The accuracy of the test set is %f \n',acc*100);
%fprintf('Program paused. Please enter the path of you image and Press enter to continue.\n');
%pause;

%%[c,cm,ind,per] = confusion(targets,outputs);

confusionMatrix = confusionchart(names, predict);
confusionMatrix.ColumnSummary = 'column-normalized';
confusionMatrix.RowSummary = 'row-normalized';

%% =============== Part 4: Testing on your own Image ================
% Please enter the path of you image below
img = imread(fullfile(datasetpath, thirdFamily, '1invasive_plants_seed_factsheet_ambrosia_artemisiifolia_01cnsh_1476383198542_eng.jpg'));
img = imresize(img,[227 227]);
predict = classify(newnet,img);

fprintf('The image detected is %s \n',predict);
