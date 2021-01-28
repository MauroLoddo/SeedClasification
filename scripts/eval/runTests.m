% Run tests
modelPathCagliari = '../models/cagliari';
modelPathCanada = '../models/canada';

% Test Canada
disp('Canada');
models = dir(fullfile(modelPathCanada, '*.mat'));

for i = 1:numel(models)
    
    modelpath = fullfile(modelPathCanada, models(i).name);
    sprintf('%s; MAvG = %f; MFM = %f; MAvA = %f', models(i).name, MAvG(modelpath), MFM(modelpath), MAvA(modelpath))

end

% Test Cagliari
disp('Cagliari');
models = dir(fullfile(modelPathCagliari, '*.mat'));

for i = 1:numel(models)
    
    modelpath = fullfile(modelPathCagliari, models(i).name);
    sprintf('%s; MAvG = %f; MFM = %f; MAvA = %f', models(i).name, MAvG(modelpath), MFM(modelpath), MAvA(modelpath))

end




