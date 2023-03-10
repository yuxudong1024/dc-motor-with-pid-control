function diffGitHub_pullrequest(modifiedFiles)

    proj = currentProject;

%     % List modified models since branch diverged from main
%     % Use *** to search recursively for modified SLX files starting in the current folder
%     % git diff --name-only refs/remotes/origin/main..refs/remotes/origin/branchtomerge
%     gitCommand = sprintf('git diff --name-only refs/remotes/origin/master..refs/remotes/origin/%s ***.slx', branchname);
%     [status,modifiedFiles] = system(gitCommand);
%     assert(status==0, modifiedFiles);
%     modifiedFiles = split(modifiedFiles);
%     modifiedFiles(end) = []; % Removing last element because it is empty
    
    if isempty(modifiedFiles)
        disp('No modified models to compare.')
        return
    else
        modifiedFiles = split(modifiedFiles);
        disp('List of Modified SLX Files:')
        % modifiedFiles(end) = []; % Removing last element because it is empty
        disp(modifiedFiles)
    end
    
    % Create a temporary folder to store the ancestors of the modified models
    % If you have models with the same name in different folders, consider
    % creating multiple folders to prevent overwriting temporary models
    disp('Creating a copy of the existing master for diff')
    tempdir = fullfile(proj.RootFolder, "modelscopy");
    mkdir(tempdir)
    
    % Generate a comparison report for every modified model file
    for i = 1:numel(modifiedFiles)
        disp(['Creating report for' modifiedFiles(i)])
        report = diffToAncestor(tempdir,string(modifiedFiles(i)));
    end
    
    % Delete the temporary folder
    rmdir modelscopy s

    disp('ReportGen Complete!')
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function report = diffToAncestor(tempdir,fileName)
    
    ancestor = getAncestor(tempdir,fileName);

    % Compare models and publish results in a printable report
    % Specify the format using 'pdf', 'html', or 'docx'
    comp= visdiff(ancestor, fileName);
    filter(comp, 'unfiltered');
    options = struct('format','doc',...
            'outputDir',fullfile(prj.RootFolder,'GeneratedArtifacts','DiffReports'));
    report = publish(comp,options);
    
end


function ancestor = getAncestor(tempdir,fileName)
    
    [relpath, name, ext] = fileparts(fileName);
    ancestor = fullfile(tempdir, name);
    
    % Replace seperators to work with Git and create ancestor file name
    fileName = strrep(fileName, '\', '/');
    ancestor = strrep(sprintf('%s%s%s',ancestor, "_ancestor", ext), '\', '/');
    % Build git command to get ancestor from main
    % git show refs/remotes/origin/main:models/modelname.slx > modelscopy/modelname_ancestor.slx
    gitCommand = sprintf('git show refs/remotes/origin/master:%s > %s', fileName, ancestor);
    
    [status, result] = system(gitCommand);
    assert(status==0, result);

end

%   Copyright 2022 The MathWorks, Inc.
