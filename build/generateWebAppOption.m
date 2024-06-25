function opts = generateWebAppOption(outputFile)

import compiler.build.WebAppArchiveOptions;

[folder, file] = fileparts(outputFile);
opts = WebAppArchiveOptions(...
    "Analysis App/dcMtr_BehaviorApp.mlapp", ...
    OutputDir=folder, ...
    ArchiveName=file);
end
