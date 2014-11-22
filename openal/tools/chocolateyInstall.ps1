try {
  $chocTempDir = Join-Path $env:TEMP 'chocolatey'
  $tempDir = Join-Path $chocTempDir 'openal'

  # Download and extract the OpenAL installer
  Install-ChocolateyZipPackage 'openal' 'http://connect.creativelabs.com/openal/Downloads/oalinst.zip' $tempDir
  
  # Run the installer
  $oalinst = Join-Path $tempDir 'oalinst.exe'
  Install-ChocolateyInstallPackage 'openal' 'exe' '/S' "$oalinst"

  Write-ChocolateySuccess 'openal'
} catch {
  Write-ChocolateyFailure 'openal' $($_.Exception.Message)
  throw
}
