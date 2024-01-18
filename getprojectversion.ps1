param (
 [string]$Filename
)
try {
 $ErrorActionPreference = 'Stop';
 $Error.Clear();
 $sourcePath = $env:GITHUB_WORKSPACE


 if ($verbose.ToLower() -eq 'verbose')
 {
  Write-Host "GetProjectVersion DEBUG"
  Write-Host "Filename   : $($Filename)"
  Write-Host "SourcePath : $($sourcePath)"
 }

 $File = Get-Item -Path (Join-Path -Path $sourcePath -ChildPath $FileName)
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
 $_.InvocationInfo | Out-String;
 throw $_.Exception.Message;
}