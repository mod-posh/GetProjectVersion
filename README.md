# Get Project Version GitHub Action

## Overview

The GetProjectVersion Action returns the current version of your project based on the version of a given project file. There are currently only two file types supported:

1. .csproj - C-Sharp project files
2. .psd1 - PowerShell Module Manifest files

## Workflow File

You can trigger the `action.yml` by `workflow_call` to post a notification automatically. The workflow contains several steps to act:

1. Checkout the repository
2. Call the `getprojectversion.ps1` script

### Workflow Inputs

- `Filename`: If the file is in the root of the repository, it's just the filename, project.csproj. If the file is inside a folder, it's the relative path to that file, MyProject\project.psd1
- `verbose`: A value of verbose will output additional information

## PowerShell Script (`getprojectversion.ps1`)

The PowerShell script opens the given project file and returns the string value of the version.

## Usage

There are a few different ways you could use this action; here is an example of one way to get you started.

```yaml
jobs:
  GetVersion:
    uses: mod-posh/GetProjectVersion@v0.0.1.3
    with:
      Filename: '"MyModule.psd1"'
      verbose: 'verbose'
```

> [!Note]
> This example is used directly as part of a larger workflow
> The verbose option will output a little more detail in the logs

## License

This project is licensed using the [Gnu GPL-3](LICENSE).
