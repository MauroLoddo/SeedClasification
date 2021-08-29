%evaluateResults

mainFolder = 'C:\Users\loand\Documents\GitHub\Tesisti\SeedClasification\classification\Cagliari\Results';
classifiers = {'Bayes', 'kNN', 'RF', 'SVM'};
CM = 'CM';
Tex = 'Tex';

for i = 1:length(classifiers)
    
    models = dir( fullfile(mainFolder, classifiers{i}, CM, '*.mat' ) );
    
    fprintf( strcat('Classifier: ', classifiers{i}));
    fprintf('\n');
    
    for j = 1:length(models)
        load( fullfile( models(j).folder, models(j).name ) );
        [stats, texMacro, texMicro] = computeStatsNoNaNs(cm);
        
        texMacro = strcat( models(j).name, " & ", texMacro, " \\" );
        texMicro = strcat( models(j).name, " & ", texMicro, " \\" );
        disp(texMacro);
        %disp(texMicro);
    end
    
    fprintf('\n');


end