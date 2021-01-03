$systemPSModules = "C:\Program Files\WindowsPowerShell\Modules"
$moduleName = "ExportPKCS7"
$moduleDirPath = Join-Path $systemPSModules $moduleName
$modulePath = Join-Path $moduleDirPath ($moduleName + ".psm1")
$moduleSrc = Join-Path (Split-Path -parent $PSCommandPath) ($moduleName + ".psm1")

$adm = [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")
if (-Not $adm) {
    Write-Host "Must be Administrator to install" -ForegroundColor Red -BackgroundColor Black
    exit
}

Write-Host "Would you like to install the `Export-PKCS7` PowerShell module?" -ForegroundColor Yellow
$Install = Read-Host " [Y] Yes  [N] No  (Default is No)"
if ($Install -ne "Y") {
    exit
}

if ((Test-Path $moduleDirPath) -And (Test-Path $modulePath)) {
    Write-Host "Module exists. Would you like to overwrite it?" -ForegroundColor Yellow
    $Overwrite = Read-Host " [Y] Yes  [N] No  (default is No)"
    if ($Overwrite -ne "Y") {
        exit
    }
    Remove-Item $moduleDirPath -Recurse
}

New-Item -ItemType Directory -Force -Path $moduleDirPath | Out-Null
$outPath = Copy-Item -Path $moduleSrc -Destination $modulePath -PassThru
Write-Host 'Module `Export-PKCS7` installed at'$outPath