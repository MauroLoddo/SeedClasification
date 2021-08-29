function [mP, mR, mAP] = EvaluateCrossRetrieval(DBTrain, labels, num, sim, postpro)

if strcmp(postpro, 'nfeat')
    DBTrain = normalize(DBTrain, 'range');
end

%fold = 10; % 10 fold cross-validation
fold = length(labels);

CVO = cvpartition(labels,'k',fold);
P = zeros(CVO.NumTestSets,1);
R = zeros(CVO.NumTestSets,1);
AP = zeros(CVO.NumTestSets,1);

for i = 1:CVO.NumTestSets
    trIdx = CVO.training(i);
    teIdx = CVO.test(i);
    [~, ~, P(i), R(i), AP(i)] =  Retrieval(DBTrain(trIdx,:), labels(trIdx,:), DBTrain(teIdx,:), labels(teIdx,:), num, sim);
end

mP = mean(P);
mR = mean(R);
mAP = mean(AP);