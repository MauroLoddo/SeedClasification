% Mean F-measure (MFM)

function [mfm] = MFM(modelpath)

    load(modelpath);
    matrix = confusionMatrix.NormalizedValues;

    sumPre = 0;
    sumRec = 0;
    sumFM = 0;
    numClasses = length(matrix);

    for i = 1:numClasses

        tp = matrix(i,i);
        totPre = sum(matrix(:, i));
        totRec = sum(matrix(i, :));

        classPre = tp / totPre;
        classRec = tp / totRec;
        classFM = ( (2*classRec * classPre) / (classRec + classPre) );

        sumPre = sumPre + classPre;
        sumRec = sumRec + classRec;

        sumFM = sumFM + classFM;

    end

    mfm = sumFM / numClasses;
end

