[params, data] = get_parameters();
logger = get_logger();
toolName = getenv("TOOL_RUN");
if isempty(toolName)
    toolName = "foobar";
endif

logger.info("start", "Starting tool run", struct("tool", toolName));
logger.info("input-loaded", "Loaded validated parameters and data paths", struct("tool", toolName, "parameter_count", numel(fieldnames(params)), "data_keys", {fieldnames(data)}));

if strcmp(toolName, "foobar")
    disp("Hello from Octave")
    disp("You have tried to run the tool 'foobar'.")
    disp("This tool is the template tool without any functionality.")
    disp("Please implement another tool or select the tool you")
    disp("have already implemented.")

    disp("\n\nLoaded Parameters:\n")
    disp(params)
    disp(data)
    logger.info("finished", "Template run finished successfully", struct("tool", toolName));
else
    logger.error("error", "Requested tool is not implemented in the template", struct("tool", toolName));
    error("Either no TOOL_RUN environment variable available, or '%s' is not valid.", toolName);
endif
