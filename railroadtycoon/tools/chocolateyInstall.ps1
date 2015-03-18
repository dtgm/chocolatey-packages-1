try {
  $chocTempDir = Join-Path $env:TEMP 'chocolatey'
  $tempDir = Join-Path $chocTempDir 'railroadtycoon'

  # Download and extract the Railroad Tycoon installer
  Install-ChocolateyZipPackage 'railroadtycoon' 'http://downloads.2kgames.com/railroads/Railroad_Tycoon.zip' $tempDir
  
  # Run the installer
  $installer = Join-Path $tempDir 'Setup Railroad Tycoon.exe'
  Install-ChocolateyInstallPackage 'railroadtycoon' 'exe' '/S' "$installer"

  Write-ChocolateySuccess 'railroadtycoon'
} catch {
  Write-ChocolateyFailure 'railroadtycoon' $($_.Exception.Message)
  throw
}
