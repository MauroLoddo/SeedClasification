% Mean, Std, Sqrt Mean

function [stats] = getStats(BW, G, areaT, name)

    if(size(name, 2) == 1)

        stats = regionprops('table', BW, G, 'Area', 'MeanIntensity', 'PixelValues');
        stats = stats(stats.Area > areaT, :);
        stds = [];
        sqrtMean = [];

        for i = 1:height(stats)
            pixels = stats{i, 'PixelValues'};
            pixels = pixels{1};
            stds = [stds; std2(pixels)];
            sqrtMean = [sqrtMean; sqrt(stats{i, 'MeanIntensity'})];
        end

        stats.StdDev = stds;
        stats.MeanSqrt = sqrtMean;

        stats = removevars(stats, {'Area', 'PixelValues'});

        stats.Properties.VariableNames{'MeanIntensity'} = ['MeanIntensity', name];
        stats.Properties.VariableNames{'StdDev'} = ['StdDev', name];
        stats.Properties.VariableNames{'MeanSqrt'} = ['MeanSqrt', name];
        
    else
        
        stats = regionprops('table', BW, G, 'Area', 'MaxIntensity', 'MinIntensity', 'MeanIntensity', 'PixelValues');
        stats = stats(stats.Area > areaT, :);
        modeS = [];
        
        for i = 1:height(stats)
            pixels = stats{i, 'PixelValues'};
            pixels = pixels{1};
            modeS = [modeS; mode(pixels)];
        end
        
        stats.Mode = modeS;

        stats = removevars(stats, {'Area', 'PixelValues'});

        stats.Properties.VariableNames{'MeanIntensity'} = ['Mean'];
        stats.Properties.VariableNames{'MaxIntensity'} = ['Max'];
        stats.Properties.VariableNames{'MinIntensity'} = ['Min'];
        
    end

end