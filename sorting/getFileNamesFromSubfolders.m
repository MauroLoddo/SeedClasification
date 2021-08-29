function fileNames = getFileNamesFromSubfolders(path, type)
    % Returns all the names of the files contained in a directory
    %
    % INPUT:
    %       path           : the directory to explore
    %       type           : class of file IMG, MAT, SCRITP, ALL(default)
    %       
    % OUTPUT:
    %       fileNames      : names (full paths) of the files in the directory

    if nargin==0
        %Select the directory browsing for the directory.
        path = uigetdir(pwd, 'Select a folder');
        type = 'ALL';
    end

    if nargin==1
        type = 'ALL';
    end

    %Read the list of files in the directory
    dirContents = dir(path);
    nFiles = size(dirContents,1);
    fileNames = cell(nFiles,1);
    idx = false(nFiles,1);
    for i = 1:nFiles
        record = fullfile(path, dirContents(i).name);
        if isdir(record) ~= 1
           switch type
               case 'ALL'
                   idx(i) = 1;
                   fileNames{i} = record;
               case {'IMG','img','IMAGE','image'}
                   [~,~,ext] = fileparts(record);
                   if strcmp(ext, '.png')==1 || strcmp(ext, '.tif')==1 || strcmp(ext, '.bmp')==1 || strcmp(ext, '.jpg')==1 || strcmp(ext, '.jpeg')==1
                       idx(i) = 1;
                       fileNames{i} = record;
                   end
               case {'MAT','mat'}
                   [~,~,ext] = fileparts(record);
                   if strcmp(ext, '.mat')==1
                       idx(i) = 1;
                       fileNames{i} = record;
                   end
              case {'XML','xml'}
                   [~,~,ext] = fileparts(record);
                   if strcmp(ext, '.xml')==1
                       idx(i) = 1;
                       fileNames{i} = record;
                   end
               case {'SCRIPT','M,','m'}
                   [~,~,ext] = fileparts(record);
                   if strcmp(ext, '.m')==1
                       idx(i) = 1;
                       fileNames{i} = record;
                   end
           end
        end
    end

    fileNames = fileNames(idx);