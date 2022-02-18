% This script is to automate the tests contained in this project

    prj = matlab.project.currentProject;
    disp(' ')
    disp("Project: " + prj.Name)
    disp('Running Model Tests...')

% Run the tests
    testSuite = sltest.testmanager.load('dcmtrCTRL_PID_Tests.mldatx');
    result = run(testSuite)

% Save test results
    disp('Saving test results...')
    sltest.testmanager.exportResults(result,'Test Results.mldatx')

% Publish testing report
    sltest.testmanager.report(result, 'testingReport.zip',...
        'IncludeTestResults',0,'IncludeComparisonSignalPlots',true,...
        'IncludeSimulationSignalPlots',true,'NumPlotRowsPerPage',3);

% Cleanup
    disp('Tests complete.')
    sltest.testmanager.clearResults
    sltest.testmanager.clear