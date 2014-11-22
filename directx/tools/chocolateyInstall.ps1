try {
  $chocTempDir = Join-Path $env:TEMP 'chocolatey'
  $tempDir = Join-Path $chocTempDir 'directx'

  # Download and extract all the different versions of DirectX
  Install-ChocolateyPackage 'directx' 'exe' "/Q /T:$tempDir" 'http://download.microsoft.com/download/8/4/A/84A35BF1-DAFE-4AE8-82AF-AD2AE20B6B14/directx_Jun2010_redist.exe'

  # Run the actual installer
  $dxSetup = Join-Path $tempDir 'DXSETUP.exe'
  Install-ChocolateyInstallPackage 'directx' 'exe' '/silent' "$dxSetup"

  Write-ChocolateySuccess 'directx'
} catch {
  Write-ChocolateyFailure 'directx' $($_.Exception.Message)
  throw
}
