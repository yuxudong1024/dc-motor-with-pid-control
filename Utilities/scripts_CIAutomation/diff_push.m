function diff_push(modifiedFiles,lastpush)
    
    proj = currentProject;

    if isempty(modifiedFiles)
        disp('No modified models to compare.')
        return
    else
        % ID all the SLX filenames and 
        modifiedFiles = split(modifiedFiles,[" ","\","/"]);
        idx = contains(modifiedFiles,".slx");
        modifiedFiles = modifiedFiles(idx);

        disp('List of Modified SLX Files:')
        disp(modifiedFiles)
    end
    
    % Create a temporary folder to store the ancestors of the modified models
    % If you have models with the same name in different folders, consider
    % creating multiple folders to prevent overwriting temporary models
    disp('Creating a copy of the previous commmits for diff')
    tempdir = fullfile(proj.RootFolder, "modelscopy");
    mkdir(tempdir)
    
    % Generate a comparison report for every modified model file
    for i = 1:numel(modifiedFiles)
        filePath = which(modifiedFiles{i});
        filePath = erase(filePath,fullfile(proj.RootFolder,'/'));
        disp(['Creating report for ' filePath])
        report = diffToAncestor(tempdir,string(filePath),lastpush);
    end
    
    % Delete the temporary folder
    rmdir modelscopy s

    disp('ReportGen Complete!')
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    function report = diffToAncestor(tempdir,fileName,lastpush)
        
        ancestor = getAncestor(tempdir,fileName,lastpush);
    
        % Compare models and publish results in a printable report
        % Specify the format using 'pdf', 'html', or 'docx'
        load_system(fileName)
        load_system(ancestor)

        comp= visdiff(ancestor, fileName);
        filter(comp, 'unfiltered');
        options = struct('Format','doc',...
            'OutputFolder',fullfile(proj.RootFolder,'GeneratedArtifacts','DiffReports'));
        report = publish(comp,options);

        close_system(fileName)
        close_system(ancestor)
        
    end
    
    
    function ancestor = getAncestor(tempdir,fileName,lastpush)
        
        [relpath, name, ext] = fileparts(fileName);
        ancestor = fullfile(tempdir, name);
        
        % Replace seperators to work with Git and create ancestor file name
        fileName = strrep(fileName, '\', '/');
        ancestor = strrep(sprintf('%s%s%s',ancestor, "_ancestor", ext), '\', '/');
        
        % Build git command to get ancestor
        % git show lastpush:models/modelname.slx > modelscopy/modelname_ancestor.slx
        gitCommand = sprintf('git show refs/remotes/origin/master %s:"%s" > "%s"', lastpush, fileName, ancestor);
        
        [status, result] = system(gitCommand);
        assert(status==0, result);
    
    end
end

%   Copyright 2022 The MathWorks, Inc.
