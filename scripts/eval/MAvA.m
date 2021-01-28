% Macro average arithmetic (MAvA)

function [mava] = MAvA(modelpath)
    
    load(modelpath);
    matrix = confusionMatrix.NormalizedValues;

    sumAcc = 0;
    numClasses = length(matrix);

    for i = 1:numClasses

        tp = matrix(i,i);
        tot = sum(matrix(:, i));
        classAcc = tp / tot;

        sumAcc = sumAcc + classAcc;

    end

    mava = sumAcc / numClasses;
end