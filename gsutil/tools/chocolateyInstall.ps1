try {
  $binRoot = Join-Path $env:systemdrive 'tools'
  $gsutilPath = Join-Path $binRoot 'gsutil'

  # Download and extract gsutil to installation path
  Install-ChocolateyZipPackage 'gsutil' 'http://storage.googleapis.com/pub/gsutil.zip' $binRoot

  # Rename gsutil to gsutil.py so it works in PowerShell
  $executableSource = Join-Path $gsutilPath 'gsutil'
  $executableDestination = Join-Path $gsutilPath 'gsutil.py'
  Copy-Item $executableSource $executableDestination

  # Add gsutil directory to PATH environment variable
  Install-ChocolateyPath $gsutilPath 'User'

  # Add .py extension to PATHEXT environment variable
  $envvar = $env:PATHEXT
  if (!$envvar.ToLower().Contains('.py')) {
    Write-Host 'Adding .py file extension to PATHEXT environment variable...'

    # Get the current value of the variable
    $envvarTarget = [System.EnvironmentVariableTarget]::Machine
    $envvarVal = [Environment]::GetEnvironmentVariable('PATHEXT', $envvarTarget)

    # Append a semi-colon to current value
    $statementTerminator = ';'
    $hasStatementTerminator = $envvarVal -ne $null -and $envvarVal.EndsWith($statementTerminator)
    If (!$hasStatementTerminator) {
      $envvarVal = $envvarVal += ';.PY;'
    } else {
      $envvarVal = $envvarVal += '.PY;'
    }

    $psArgs = "[Environment]::SetEnvironmentVariable('PATHEXT', `'$envvarVal`', `'$envvarTarget`')"
    Start-ChocolateyProcessAsAdmin "$psArgs"
  }

  Write-ChocolateySuccess 'gsutil'
} catch {
  Write-ChocolateyFailure 'gsutil' $($_.Exception.Message)
  throw
}
