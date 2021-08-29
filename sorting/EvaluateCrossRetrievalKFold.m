function [mP, mR, mAP] = EvaluateCrossRetrievalKFold(DBTrain, labels, num, sim, postpro)

if strcmp(postpro, 'nfeat')
    DBTrain = normalize(DBTrain, 'range');
end

%fold = 10; % 10 fold cross-validation
fold = length(labels);
numPart = 100;

CVO = cvpartition(labels,'k',fold);

P = zeros(numPart,1);
R = zeros(numPart,1);
AP = zeros(numPart,1);

for i = 1:numPart
    r = (numPart-1).*rand() + 1;
    r = int8(r);
    trIdx = CVO.training(r);
    teIdx = CVO.test(r);
    [~, ~, P(r), R(r), AP(r)] =  Retrieval(DBTrain(trIdx,:), labels(trIdx,:), DBTrain(teIdx,:), labels(teIdx,:), num, sim);
end

mP = mean(P);
mR = mean(R);
mAP = mean(AP);