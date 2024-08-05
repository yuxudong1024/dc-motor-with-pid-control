function plan = buildfile
import matlab.buildtool.tasks.CodeIssuesTask
import matlab.buildtool.tasks.TestTask

plan = buildplan(localfunctions,ImplicitTaskGroups=true);

% Setup the MinGW compiler
%   Ad hoc task, task action defined in setupCompilerTask local function
plan("setupCompiler").Inputs = "build/installMinGW.m";

plan.DefaultTasks = "ctf";

% Lint the code and tests
plan("lint") = CodeIssuesTask(Results="results/code-issues.sarif");

% Build a MATLAB WebApp Server archive
%   Ad hoc task, task action defined in toolboxTask local function
plan("ctf").Dependencies = ["lint","setupCompiler"];
plan("ctf").Inputs = "build/generateWebAppOption.m";
plan("ctf").Outputs = [...
    "GeneratedArtifacts/DeployableApps/dcMtr_BehaviorApp.ctf", ...
    "GeneratedArtifacts/DeployableApps"];

%% Create the deploy task - does nothing but depends on other tasks
plan("deploy") = matlab.buildtool.Task(Dependencies="ctf", ...
    Description="Produce a ctf archive to deploy to a MATLAB WebApp Server");

% Codegen

% plan('codegen').Dependencies = ["lint","setupCompiler"];

end

function setupCompilerTask(~)
% Setup MEX compiler
try
    mex("-setup");
    return
catch
    disp("No compiler detected. Installing compiler.")
end
if ispc
    installMinGW
    return
end

disp("Don't know how to install a compiler for this platform.")
end
   
function ctfTask(context)
% Create a deployable archive for MATLAB WebApp Server
import compiler.build.webAppArchive 

ctfArchive = context.Task.Outputs(1).paths;

ctfBuildResults = context.Task.Outputs(2).paths;

opts = generateWebAppOption(ctfArchive);
buildResults = webAppArchive(opts);
save(ctfBuildResults,"buildResults");
end

% function codegenTask(context)
% %import 
% 
% end
