param (
    [string]$Filename
)

try {
    $ErrorActionPreference = 'Stop';
    $Error.Clear();
    $verbose = $env:VERBOSE

    $runnerPath = $env:GITHUB_WORKSPACE

    if ($verbose.ToLower() -eq 'verbose') {
        Write-Host "GetProjectVersion DEBUG"
        Write-Host "Filename   : $($Filename)"
        Write-Host "RunnerPath : $($runnerPath)"
        Write-Host "SourcePath : $($File.FullName)"
    }

    # Search for the file recursively within the runner path
    $File = Get-ChildItem -Path $runnerPath -Recurse -Filter $Filename -File | Select-Object -First 1

    if (-not $File) {
        throw "File '$Filename' not found in $runnerPath"
    }

    switch ($File.Extension) {
        '.csproj' {
            $Project = [xml](Get-Content -Path $File.FullName);
            $Version = $Project.Project.PropertyGroup.Version.ToString();
        }
        '.psd1' {
            $Manifest = Test-ModuleManifest -Path $File.FullName -ErrorAction SilentlyContinue
            $Version = $Manifest.Version.ToString()
        }
        '.props' {
            $Props = [xml](Get-Content -Path $File.FullName);
            $Version = $Props.Project.PropertyGroup.Version.ToString();
        }
        default {
            throw "The extension, $($File.Extension) is not currently a supported type, please create an issue to address this"
        }
    }

    if ($verbose.ToLower() -eq 'verbose') {
        Write-Host "Extension  : $($File.Extension)"
        Write-Host "Version    : $($Version)"
    }

    # Set the output using environment files
    $envFile = [System.IO.Path]::Combine($env:GITHUB_ENV)
    Add-Content -Path $envFile -Value "VERSION=$Version"
} catch {
    $_.InvocationInfo | Out-String
    throw $_.Exception.Message;
}
