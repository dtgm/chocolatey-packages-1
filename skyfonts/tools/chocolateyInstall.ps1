try {
  $chocTempDir = Join-Path $env:TEMP 'chocolatey'
  $tempDir = Join-Path $chocTempDir 'skyfonts'

  # Download and extract the ZIP file
  Install-ChocolateyZipPackage 'skyfonts' 'http://www.skyfonts.com/Extension/Prod/Monotype_SkyFonts_Winx86_3.0.0.1.exe.zip' $tempDir 'http://www.skyfonts.com/Extension/Prod/Monotype_SkyFonts_Winx64_3.0.0.1.exe.zip'

  # Run the installer
  $installer = Join-Path $tempDir 'Monotype_SkyFonts_Winx64_3.0.0.1.exe'
  $installer32 = Join-Path $tempDir 'Monotype_SkyFonts_Winx86_3.0.0.1.exe'
  if (Test-Path $installer) {
    Install-ChocolateyInstallPackage 'skyfonts' 'exe' '/q' "$installer"
  } else {
    Install-ChocolateyInstallPackage 'skyfonts' 'exe' '/q' "$installer32"
  }

  Write-ChocolateySuccess 'skyfonts'
} catch {
  Write-ChocolateyFailure 'skyfonts' $($_.Exception.Message)
  throw
}
