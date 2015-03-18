try {
  $games = Join-Path $env:systemdrive 'games'
  $skifree = Join-Path $games 'skifree'

  # Download and extract SkiFree to installation path
  Install-ChocolateyZipPackage 'skifree' 'http://ski.ihoc.net/ski32.zip' $skifree

  Write-ChocolateySuccess 'skifree'
} catch {
  Write-ChocolateyFailure 'skifree' $($_.Exception.Message)
  throw
}
