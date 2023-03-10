% This script is to automate the tests contained in this project

    prj = matlab.project.currentProject;
    disp(' ')
    disp("Project: " + prj.Name)
    disp('Running Model Tests...')

% Load test file and setup plugins to generate usable test reports
    testsName = 'dcmtrCTRL_PID_Tests';
    testSuite = sltest.testmanager.load([testsName '.mldatx']);
    
    import matlab.unittest.TestSuite
    suite = testsuite([testsName '.mldatx']);
    
    import matlab.unittest.TestRunner
    myrunner = TestRunner.withNoPlugins;

    import sltest.plugins.TestManagerResultsPlugin
    mldatxFileName = fullfile(prj.RootFolder,...
        'GeneratedArtifacts','TestResults',[testsName '_Results.mldatx']);
    tmr = TestManagerResultsPlugin('ExportToFile',mldatxFileName); 
    addPlugin(myrunner,tmr)

    import matlab.unittest.plugins.TestReportPlugin
    import matlab.unittest.plugins.TAPPlugin
    import matlab.unittest.plugins.XMLPlugin
    import matlab.unittest.plugins.ToFile

    pdfFile = fullfile(prj.RootFolder,'GeneratedArtifacts','TestResults',[testsName '.pdf']);
    trp = TestReportPlugin.producingPDF(pdfFile);
    addPlugin(myrunner,trp)

    tapFile = fullfile(prj.RootFolder,'GeneratedArtifacts','TestResults',[testsName '.tap']);
    tap = TAPPlugin.producingVersion13(ToFile(tapFile));
    addPlugin(myrunner,tap)
    
    xmlFile = fullfile(prj.RootFolder,'GeneratedArtifacts','TestResults',[testsName '.xml']);
    p = XMLPlugin.producingJUnitFormat(xmlFile);
    addPlugin(myrunner,p)

% Run the tests
    result = run(myrunner,suite)
    
% Generate C Code
    % mdlName = {'dcmtrCtrl_PID','dcmtrCtrl_PID_send2Ardu',...
    %           'dcmtrCtrl_PID_wHandCode'};
    % slbuild(mdlName) 
    % % Saved in currentProject().SimulinkCodeGenFolder

% Cleanup
    disp('Tests complete.')
    sltest.testmanager.clearResults
    sltest.testmanager.clear