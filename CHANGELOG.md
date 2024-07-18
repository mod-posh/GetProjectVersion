# Changelog

All changes to this project should be reflected in this document.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [[0.0.2.1]](https://github.com/mod-posh/GetProjectVersion/releases/tag/v0.0.2.1) - 2024-07-17

There was a problem with accessing the output of the action, this should be resolved with this release.

What's Changed:

1. **PowerShell Script (`getprojectversion.ps1`)**:
   - Use set-output `Write-Output "::set-output name=Version::$($Version)"`

2. **GitHub Action YAML (`action.yml`)**:
   - Use set-output `echo "::set-output name=Version::$Version"`

## [[0.0.2.0]](https://github.com/mod-posh/GetProjectVersion/releases/tag/v0.0.2.0) - 2024-07-17

There was a problem with accessing the output of the action, this should be resolved with this release.

What's Changed:

1. **PowerShell Script (`getprojectversion.ps1`)**:
   - Corrected the variable name for `$Filename` in `Join-Path`.
   - Ensured `Write-Output` is used instead of `return` to properly capture the output for the calling environment.

2. **GitHub Action YAML (`action.yml`)**:
   - Used `echo "Version=$Version" >> $GITHUB_ENV` to correctly set the environment variable for the output in GitHub Actions.
   - Ensured the PowerShell script path is correctly formatted for cross-platform compatibility by wrapping the path in double quotes.

## [[0.0.1.7]](https://github.com/mod-posh/GetProjectVersion/releases/tag/v0.0.1.7) - 2024-01-18

Warning: The `set-output` command is deprecated and will be disabled soon. Please upgrade to using Environment Files. For more information see: [GitHub Actions: Deprecating save-state and set-output commands](https://github.blog/changelog/2022-10-11-github-actions-deprecating-save-state-and-set-output-commands/)

### Unsupported

```yml
- name: Set output
run: echo "::set-output name={name}::{value}"
```

### Supported

```yml
- name: Set output
run: echo "{name}={value}" >> $GITHUB_OUTPUT
```

What's Changed:

1. Updated action.yml with new output format

---

## [[0.0.1.6]](https://github.com/mod-posh/GetProjectVersion/releases/tag/v0.0.1.6) - 2024-01-18

BUGFIX: Wasn't capturing env:VERBOSE

---

## [[0.0.1.5]](https://github.com/mod-posh/GetProjectVersion/releases/tag/v0.0.1.5) - 2024-01-18

BUGFIX: Need more error output

---

## [[0.0.1.4]](https://github.com/mod-posh/GetProjectVersion/releases/tag/v0.0.1.4) - 2024-01-18

BUGFIX: Script is erroring out early on, moving some verbose statements around

---

## [[0.0.1.3]](https://github.com/mod-posh/GetProjectVersion/releases/tag/v0.0.1.3) - 2024-01-18

BUGFIX: Outputs are not available in composite actions

---

## [[0.0.1.2]](https://github.com/mod-posh/GetProjectVersion/releases/tag/v0.0.1.2) - 2024-01-18

BUGFIX: Outputs shoud be the same level as runs

---

## [[0.0.1.1]](https://github.com/mod-posh/GetProjectVersion/releases/tag/v0.0.1.1) - 2024-01-18

BUGFIX: Adjust indentation of outputs

---

## [[0.0.1.0]](https://github.com/mod-posh/GetProjectVersion/releases/tag/v0.0.1.0) - 2024-01-18

This is the initial release of this action. It can be used to pass the project version to another action in your workflow.

---
