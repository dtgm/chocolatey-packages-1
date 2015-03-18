try {
  $chocTempDir = Join-Path $env:TEMP 'chocolatey'
  $tempDir = Join-Path $chocTempDir 'osu'
  if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir) | Out-Null}

  # Download and extract the MSI installer
  Get-ChocolateyWebFile 'osu' "$tempDir/osu!install.exe" 'http://osu.hiroto.eu/osu!install.exe'
  $s = [System.Diagnostics.Process]::Start("$tempDir/osu!install.exe", "/EXTRACTMSI:$tempDir/installer.msi")
  $s.WaitForExit();

  Install-ChocolateyPackage 'osu' 'msi' '/quiet' "$tempDir/installer.msi"

  Write-ChocolateySuccess 'osu'
} catch {
  Write-ChocolateyFailure 'osu' $($_.Exception.Message)
  throw
}
