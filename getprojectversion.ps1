param (
 [string]$Filename
)
try {
 $ErrorActionPreference = 'Stop';
 $Error.Clear();
 $verbose = $env:VERBOSE

 $runnerPath = $env:GITHUB_WORKSPACE
 $sourcePath = Join-Path -Path $runnerPath -ChildPath $FileName

 if ($verbose.ToLower() -eq 'verbose')
 {
  Write-Host "GetProjectVersion DEBUG"
  Write-Host "Filename   : $($Filename)"
  Write-Host "RunnerPath : $($runnerPath)"
  Write-Host "SourcePath : $($sourcePath)"
 }

 $File = Get-Item -Path $sourcePath
 switch ($File.Extension)
 {
  '.csproj'
  {
   $Project = [xml](Get-Content -Path $File.FullName);
   $Version = $Project.Project.PropertyGroup.Version.ToString();
  }
  '.psd1'
  {
   $Manifest = Test-ModuleManifest -Path $File.FullName -ErrorAction SilentlyContinue
   $Version = $Manifest.Version.ToString()
  }
  default
  {
   throw "The extension, $($File.Extension) is not currently a supported type, please create an issue to address this"
  }
 }

 if ($verbose.ToLower() -eq 'verbose')
 {
  Write-Host "Extension  : $($File.Extension)"
  Write-Host "Version    : $($Version)"
 }

 return $Version
} catch {
 $_.InvocationInfo | Out-String
 throw $_.Exception.Message;
}