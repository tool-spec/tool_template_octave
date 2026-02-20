disp("Hello from Octave")
disp("You have tried to run the tool 'foobar'.")
disp("This tool is the template tool without any functionality.")
disp("Please implement another tool or select the tool you")
disp("have already implemented.")

disp("\n\nLoaded Parameters:\n")

[params, data] = get_parameters();
disp(params)
disp(data)
