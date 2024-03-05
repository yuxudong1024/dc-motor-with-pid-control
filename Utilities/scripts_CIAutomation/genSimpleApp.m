function genSimpleApp()
% This script is to automate the webview generation of models contained in this project

% List names of all models for which code is being generated
    appName = {'dcMtr_BehaviorApp'};

% Get handle to project
    prj = matlab.project.currentProject;
    disp(' ')
    disp("Project: " + prj.Name)

% Generate app
    for i = 1:length(appName)
        disp(['Generating App of ' appName{i} '...'])

        mcc('-m',[appName{i} '.mlapp'], ...
            '-d',fullfile(prj.RootFolder,'GeneratedArtifacts','DeployableApps',appName{i}))
    end

% Cleanup
    bdclose all
    bdclose all
    disp('closed any and all open Simulink files')
    
    rmdir Work/slprj s
    disp('SLPRJ files deleted')

    disp('App Generation complete.')