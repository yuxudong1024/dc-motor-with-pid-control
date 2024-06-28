function scrubSharedUtils()
% Clear shared utils from previous builds for clean Codegen/SiL
    prj = currentProject;
    fldrname = fullfile(prj.SimulinkCodeGenFolder,'slprj');
    if isfolder(fldrname)
        rmdir(fldrname,'s')
    end 