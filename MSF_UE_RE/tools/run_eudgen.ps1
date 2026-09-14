# Compile EudGenMsf.cs and run it in an AppDomain rooted at the EUD Editor folder.
# Called by build_scrdb.py --regen. Keep this file ASCII (Windows PowerShell 5.1 reads it as ANSI).
param(
    [Parameter(Mandatory = $true)][string]$EudDir,
    [Parameter(Mandatory = $true)][string]$E3s,
    [Parameter(Mandatory = $true)][string]$Out,
    [Parameter(Mandatory = $true)][string]$MainEps,
    [Parameter(Mandatory = $true)][string]$Open,
    [Parameter(Mandatory = $true)][string]$Save
)
$ErrorActionPreference = "Stop"
if (-not $EudDir.EndsWith("\")) { $EudDir += "\" }
New-Item -ItemType Directory -Force $Out | Out-Null
$src = Join-Path $PSScriptRoot "EudGenMsf.cs"
$dll = Join-Path $Out ("EudGenMsf_" + (Get-Date -Format "HHmmss") + ".dll")
Add-Type -Path $src -OutputAssembly $dll -OutputType Library
$local = [Reflection.Assembly]::LoadFrom($dll)
$setup = New-Object AppDomainSetup
$setup.ApplicationBase = $EudDir
$setup.ConfigurationFile = $EudDir + "EUD Editor 3.exe.config"
$dom = [AppDomain]::CreateDomain("eudgen", $null, $setup)
try {
    $gen = $dom.CreateInstanceFromAndUnwrap($dll, "EudGenMsf")
    $log = $local.GetType("EudGenMsf").GetMethod("Run").Invoke($gen, [object[]]@($EudDir, $E3s, $Out, $MainEps, $Open, $Save))
    $log
} finally {
    [AppDomain]::Unload($dom)
}
