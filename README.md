# tool_template_octave

[![Docker Image CI](https://github.com/tool-spec/tool_template_octave/actions/workflows/docker-image.yml/badge.svg)](https://github.com/tool-spec/tool_template_octave/actions/workflows/docker-image.yml)
[![DOI](https://zenodo.org/badge/558417725.svg)](https://doi.org/10.5281/zenodo.7645900)

Template repository for building an Octave tool that follows the [Tool Specification](https://tool-spec.github.io/tool-specs/) container contract.

## How `gotap` works here

This template installs [`gotap`](https://github.com/tool-spec/gotap) inside the image and uses it as the default runtime shim:

```Dockerfile
CMD ["gotap", "run", "foobar", "--input-file", "/in/input.json"]
```

At build time, `gotap generate` creates `get_parameters.m` from `src/tool.yml`. At runtime, `runTool.m` uses the generated helper to validate `/in/input.json`, load parameters and data paths, and write structured run logs.

## Required file structure

```text
/
|- in/
|  |- input.json
|- out/
|  |- ...
|- src/
|  |- tool.yml
|  |- runTool.m
|  |- get_parameters.m   (generated at build time)
|  |- CITATION.cff
```

## Build and run

Build the image from the template root:

```bash
docker build -t tbr_octave_template .
```

Run the sample tool:

```bash
docker run --rm -it \
  -v "$(pwd)/in:/in" \
  -v "$(pwd)/out:/out" \
  -e TOOL_RUN=foobar \
  tbr_octave_template
```

`TOOL_RUN` is only needed when the image contains more than one tool entry.

## Customize

1. Update `src/tool.yml` to describe your tool.
2. Add Octave or system dependencies in `Dockerfile`.
3. Implement the tool logic in `src/runTool.m`.
4. Rebuild the image so `gotap generate` refreshes `get_parameters.m`.

## Generated bindings and platform note

The generated `get_parameters.m` helper is the only supported parameter-access path in this template. It exposes:

- `get_parameters()`
- `get_run_context()`
- `get_logger()`

On the current arm64 macOS Docker host, `gnuoctave/octave:8.1.0` does not publish a matching image manifest, so image builds are currently blocked by platform availability rather than by the template contract.
