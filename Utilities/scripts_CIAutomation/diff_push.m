function diff_push(modifiedFiles,lastpush)
% Function to produce the diff reports as DOC files between the latest version
% of the master branch, and the previous version of the master branch. 
% This function takes the names of SLX files identified when running git diff.

% To run This function, you should first run a git diff
% $diffM= git diff --name-only --diff-filter=M $previousCommit $latestCommit -- **/*.slx

    proj = currentProject;

    % List out names of all SLX files within Repo that were modified
    if isempty(modifiedFiles)
        disp('No modified models to compare.')
        return
    else
        modifiedFiles = split(modifiedFiles,[" ","\","/"]);
        idx = contains(modifiedFiles,".slx");
        modifiedFiles = modifiedFiles(idx);

        disp('List of Modified SLX Files:')
        disp(modifiedFiles)
    end
    
    % Create a temporary folder to store the ancestors of the modified models
    % If you have models with the same name in different folders, consider
    % creating multiple folders to prevent overwriting temporary models
    disp('Creating a local folder called "modelscopy" to hold the previous version of the SLX')
    disp('A copy of the previous committed version of the slx will be added into this folder for diffs')
    tempdir = fullfile(proj.RootFolder, "modelscopy");
    mkdir(tempdir)
    disp('Folder Created!')

    
    % Generate a comparison report for every modified model file
    for i = 1:numel(modifiedFiles)
        filePath = which(modifiedFiles{i});
        filePath = erase(filePath,fullfile(proj.RootFolder,'/'));
        disp(['Creating report for ' filePath])
        report = diffToAncestor(tempdir,string(filePath),lastpush);
        disp(['Report creation complete for ' filePath])
    end
    
    % Delete the temporary folder
    disp('Removing the "modelscopy" folder')
    rmdir modelscopy s

    disp('ReportGen Complete!')

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    function report = diffToAncestor(tempdir,fileName,lastpush)
        disp("    Getting the ancestor version of the SLX file")
        disp(strcat("    SLX File Name = ", fileName, "; lastpush = " ,lastpush))
        ancestor = getAncestor(tempdir,fileName,lastpush);
    
        % Compare models and publish results in a printable report
        % Specify the format using 'pdf', 'html', or 'docx'
            disp(strcat("    Load the model:  ", fileName))
            load_system(fileName)
            disp(strcat("    Load the model:  ", ancestor))
            load_system(ancestor)
            disp('    Run the "visdiff" command')
            comp= visdiff(ancestor, fileName);
            disp('    Save the "visdiff" output as a doc')
            filter(comp, 'unfiltered');
            options = struct('Format','doc',...
                'OutputFolder',fullfile(proj.RootFolder,'GeneratedArtifacts','DiffReports'));
            report = publish(comp,options);
    
            close_system(fileName,0)
            close_system(ancestor,0)
    
    
        function ancestor = getAncestor(tempdir,fileName,lastpush)
            
            [relpath, name, ext] = fileparts(fileName);
            ancestor = fullfile(tempdir, name);
            disp(strcat("        Locaiton to save in the ancestor file is: ", ancestor))
            
            % Replace seperators to work with Git and create ancestor file name
            fileName = strrep(fileName, '\', '/');
            ancestor = strrep(sprintf('%s%s%s',ancestor, "_ancestor", ext), '\', '/');
            disp(strcat("        Name to save in the ancestor file is: ", ancestor))
            
            % Build git command to get ancestor
            % git show lastpush:models/modelname.slx > modelscopy/modelname_ancestor.slx
            gitCommand = sprintf('git show %s:"%s" > "%s"', lastpush, fileName, ancestor);
            disp("        Executing the following git command using the 'system' function in MATLAB: ")
            disp(strcat("            ",gitCommand))
            
            [status, result] = system(gitCommand);
            assert(status==0, result);
            disp('        Copied over the Previous version of the SLX file into the "modelscopy" folder')
        
        end
    end
end
       
    
%   Copyright 2023 The MathWorks, Inc.
