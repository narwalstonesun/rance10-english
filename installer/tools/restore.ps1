# Rance X English Translation - restore the files saved by the installer
param([string]$GameDir = '', [switch]$Elevated)
$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$root = Split-Path -Parent $here
function Say($t, $c = 'Gray') { Write-Host $t -ForegroundColor $c }
function Done($code) { Write-Host ''; if (-not $env:REV_NOPAUSE) { Read-Host 'Press Enter to close' }; exit $code }
function Find-Game {
    foreach ($r in @(${env:ProgramFiles(x86)}, $env:ProgramFiles) | Where-Object { $_ }) {
        $hit = Get-ChildItem -Path (Join-Path $r 'AliceSoft') -Directory -ErrorAction SilentlyContinue |
            Where-Object { Test-Path (Join-Path $_.FullName 'Rance10.exe') } | Select-Object -First 1
        if ($hit) { return $hit.FullName }
    }
    if (Test-Path (Join-Path $root 'Rance10.exe')) { return $root }
    return ''
}
Say '=== Rance X English Translation - restore ===' 'Cyan'
if (-not $GameDir) { $GameDir = Find-Game }
if (-not $GameDir) {
    Add-Type -AssemblyName System.Windows.Forms
    $dlg = New-Object System.Windows.Forms.FolderBrowserDialog
    $dlg.Description = 'Select the Rance X game folder (the one containing Rance10.exe)'
    if ($dlg.ShowDialog() -eq 'OK') { $GameDir = $dlg.SelectedPath }
}
$bak = Join-Path $GameDir '_EnglishRevision_backup'
if (-not (Test-Path $bak)) { Say 'No backup folder found - nothing to restore.' 'Yellow'; Done 0 }
$running = Get-Process -Name 'Rance10' -ErrorAction SilentlyContinue | Where-Object { -not $_.Path -or ([IO.Path]::GetDirectoryName($_.Path)).TrimEnd([char]92) -ieq $GameDir.TrimEnd([char]92) }
if ($running) { Say 'Please close the game first.' 'Red'; Done 1 }
$probe = Join-Path $GameDir '_write_test.tmp'
try { [IO.File]::WriteAllText($probe, 'x'); Remove-Item $probe -Force }
catch {
    if ($Elevated) { Say 'No write access to the game folder.' 'Red'; Done 1 }
    Start-Process powershell -Verb RunAs -ArgumentList @('-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', "`"$PSCommandPath`"", '-GameDir', "`"$GameDir`"", '-Elevated')
    exit 0
}
Get-ChildItem $bak -File | ForEach-Object {
    Copy-Item -LiteralPath $_.FullName -Destination (Join-Path $GameDir $_.Name) -Force
    Say "  restored $($_.Name)" 'Green'
}
Say 'Done. The backup folder was kept; delete it yourself if you no longer need it.' 'Green'
Done 0
