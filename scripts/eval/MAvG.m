% Macro average geometric (MAvG)

function [mavg] = MAvG(modelpath)

    load(modelpath);
    matrix = confusionMatrix.NormalizedValues;

    prod = 1;
    numClasses = length(matrix);

    for i = 1:numClasses

        tp = matrix(i,i);
        tot = sum(matrix(:, i));
        classAcc = tp / tot;
        prod = prod * classAcc;

    end

    mavg = prod ^ (1/numClasses);

end