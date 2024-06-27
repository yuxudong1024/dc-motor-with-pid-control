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
        
        % appLocation = which(appName{i});

        % mcc('-m',appLocation, ...
        %    '-d',fullfile(prj.RootFolder,'GeneratedArtifacts','DeployableApps',appName{i}))

    % Create target build options object, set build properties and build.
        buildOpts = compiler.build.StandaloneApplicationOptions(fullfile(prj.RootFolder,"Analysis App", [appName+".mlapp"]));
        buildOpts.AutoDetectDataFiles = true;
        buildOpts.OutputDir = fullfile(prj.RootFolder,'GeneratedArtifacts','DeployableApps',appName{i});
        buildOpts.Verbose = true;
        buildOpts.EmbedArchive = true;
        buildOpts.ExecutableName = appName{i};
        buildOpts.ExecutableVersion = "1.0";
        buildOpts.TreatInputsAsNumeric = false;
        buildResult = compiler.build.standaloneApplication(buildOpts);

    end

% Cleanup
    bdclose all
    bdclose all
    disp('closed any and all open Simulink files')
    
    if isfolder(fullfile(prj.SimulinkCacheFolder,'slprj'))
        rmdir(fullfile(prj.SimulinkCacheFolder,'slprj'),"s")
        disp('SLPRJ Cache files deleted')
    end

    disp('App Generation complete.')