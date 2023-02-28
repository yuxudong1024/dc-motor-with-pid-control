% This script is to automate the tests contained in this project

    prj = matlab.project.currentProject;
    disp(' ')
    disp("Project: " + prj.Name)
    disp('Running Model Advisor Checks for Misra C:2012 ...')

% Run the Checks
    mdlName = {'dcmtrCtrl_PID'};
    
    checkIDs = {'mathworks.misra.CodeGenSettings',...
        'mathworks.codegen.PCGSupport',...
        'mathworks.misra.BlkSupport',...
        'mathworks.misra.BlockNames',...
        'mathworks.misra.AssignmentBlocks',...
        'mathworks.misra.SwitchDefault',...
        'mathworks.misra.AutosarReceiverInterface',...
    	'mathworks.misra.CompliantCGIRConstructions',...
        'mathworks.misra.RecursionCompliance',...
        'mathworks.misra.CompareFloatEquality',...
        'mathworks.misra.ModelFunctionInterface',...
        'mathworks.misra.IntegerWordLengths',...
        'mathworks.misra.BusElementNames'};
    
    results = ModelAdvisor.run(mdlName,checkIDs,...
        'DisplayResults','Details',...
        'ReportFormat','pdf','ReportPath', prj.RootFolder,...
        'ReportName',[mdlName{1} '_MISRAchecks']);

% Cleanup
    disp('Checks complete.')