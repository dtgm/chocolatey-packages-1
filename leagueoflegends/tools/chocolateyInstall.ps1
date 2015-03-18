$chocTempDir = Join-Path $env:TEMP "chocolatey"
$tempDir = Join-Path $chocTempDir "leagueoflegends"
if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir)}
$setupConfig = Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) "setup.iss"
Copy-Item $setupConfig $tempDir
$setupPath = Join-Path $tempDir "setup.iss"
$parameters = @"
/s /f1"$setupPath"
"@

Install-ChocolateyPackage 'leagueoflegends' 'exe' $parameters 'http://l3cdn.riotgames.com/Installer/SingleFileInstall/LeagueOfLegendsBaseNA.exe'
