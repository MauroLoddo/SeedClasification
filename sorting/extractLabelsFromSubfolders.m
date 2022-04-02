function labels = extractLabelsFromSubfolders()  

    labels = [];

    % Define a starting folder.
    start_path = fullfile('.');
    % Ask user to confirm or change.
    topLevelFolder = uigetdir(start_path);
    if topLevelFolder == 0
        return;
    end
    
    % Get list of all subfolders.
    allSubFolders = genpath(topLevelFolder);
    % Parse into a cell array.
    remain = allSubFolders;
    listOfFolderNames = {};
    datasetName = strsplit(topLevelFolder, '\');
    datasetName = convertCharsToStrings( datasetName{end} );
    
    while true
        [singleSubFolder, remain] = strtok(remain, ';');
        if isempty(singleSubFolder)
            break;
        end
        listOfFolderNames = [listOfFolderNames singleSubFolder];
    end
    numberOfFolders = length(listOfFolderNames)


    % Process all image files in those folders.
    for k = 1 : numberOfFolders
        % Get this folder and print it out.
        thisFolder = listOfFolderNames{k};
        fprintf('Processing folder %s\n', thisFolder);

        % Get PNG files.
        filePattern = sprintf('%s/*.png', thisFolder);
        baseFileNames = dir(filePattern);
        % Add on TIF files.
        filePattern = sprintf('%s/*.tif', thisFolder);
        baseFileNames = [baseFileNames; dir(filePattern)];
        % Add on JPG files.
        filePattern = sprintf('%s/*.jpg', thisFolder);
        baseFileNames = [baseFileNames; dir(filePattern)];
        numberOfImageFiles = length(baseFileNames);
        % Now we have a list of all files in this folder.

        if numberOfImageFiles >= 1
            % Go through all those image files.
            for f = 1 : numberOfImageFiles
                fullFileName = fullfile(thisFolder, baseFileNames(f).name);
                fprintf('     Processing image file %s\n', fullFileName);
                label = strsplit(thisFolder, '\');
                label = convertCharsToStrings(label{end});
                labels = [labels; label]; 
            end
        else
            fprintf('     Folder %s has no image files in it.\n', thisFolder);
        end
    end
    
    save(fullfile('Labels', datasetName+'.mat'), 'labels');
    
end