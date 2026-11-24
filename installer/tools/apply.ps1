# Rance X English Revision - patch installer
# Applies xdelta patches to the game files, after checking that every file is a version the patch knows.
# Originals are copied to <game folder>\_EnglishRevision_backup first (Restore.bat puts them back).
param([string]$GameDir = '', [switch]$Elevated)
$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$root = Split-Path -Parent $here
$xd = Join-Path $here 'xdelta3.exe'
$pd = Join-Path $root 'patches'

function Say($t, $c = 'Gray') { Write-Host $t -ForegroundColor $c }
function Done($code) { Write-Host ''; if (-not $env:REV_NOPAUSE) { Read-Host 'Press Enter to close' }; exit $code }

function Find-Game {
    $roots = @(${env:ProgramFiles(x86)}, $env:ProgramFiles) | Where-Object { $_ }
    foreach ($r in $roots) {
        $hit = Get-ChildItem -Path (Join-Path $r 'AliceSoft') -Directory -ErrorAction SilentlyContinue |
            Where-Object { Test-Path (Join-Path $_.FullName 'Rance10.exe') } | Select-Object -First 1
        if ($hit) { return $hit.FullName }
    }
    if (Test-Path (Join-Path $root 'Rance10.exe')) { return $root }
    return ''
}

Say '=== Rance X English Revision - installer ===' 'Cyan'
if (-not $GameDir) { $GameDir = Find-Game }
if (-not $GameDir) {
    Add-Type -AssemblyName System.Windows.Forms
    $dlg = New-Object System.Windows.Forms.FolderBrowserDialog
    $dlg.Description = 'Select the Rance X game folder (the one containing Rance10.exe)'
    if ($dlg.ShowDialog() -eq 'OK') { $GameDir = $dlg.SelectedPath }
}
if (-not $GameDir -or -not (Test-Path (Join-Path $GameDir 'Rance10.exe'))) { Say 'Could not find Rance10.exe. Run again and choose the game folder.' 'Red'; Done 1 }
Say "Game folder: $GameDir"

$ver = (Get-Content (Join-Path $GameDir 'Version.txt') -ErrorAction SilentlyContinue | Select-Object -First 1)
if ($ver -and $ver.Trim() -ne '1.04') { Say "This patch needs game version 1.04 (Version.txt says '$ver'). Update the game first." 'Red'; Done 1 }
$running = Get-Process -Name 'Rance10' -ErrorAction SilentlyContinue | Where-Object { -not $_.Path -or ([IO.Path]::GetDirectoryName($_.Path)).TrimEnd([char]92) -ieq $GameDir.TrimEnd([char]92) }
if ($running) { Say 'Please close the game first, then run this again.' 'Red'; Done 1 }

# write access (Program Files needs administrator rights)
$probe = Join-Path $GameDir '_write_test.tmp'
try { [IO.File]::WriteAllText($probe, 'x'); Remove-Item $probe -Force }
catch {
    if ($Elevated) { Say 'No write access to the game folder even as administrator.' 'Red'; Done 1 }
    Say 'Administrator rights are needed to change files in the game folder. Asking Windows...' 'Yellow'
    Start-Process powershell -Verb RunAs -ArgumentList @('-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', "`"$PSCommandPath`"", '-GameDir', "`"$GameDir`"", '-Elevated')
    exit 0
}

$rows = Import-Csv (Join-Path $pd 'manifest.csv')
$files = $rows | Select-Object -ExpandProperty file -Unique
$plan = @(); $problems = @()
Say ''
Say 'Checking game files (this takes a minute for the large archives)...'
foreach ($f in $files) {
    $path = Join-Path $GameDir $f
    if (-not (Test-Path $path)) { $problems += "$f is missing"; continue }
    $md5 = (Get-FileHash -Algorithm MD5 -LiteralPath $path).Hash
    $mine = $rows | Where-Object { $_.file -eq $f }
    if ($md5 -eq $mine[0].target_md5) { Say "  $f - already patched"; continue }
    $row = $mine | Where-Object { $_.source_md5 -eq $md5 } | Select-Object -First 1
    if (-not $row) { $problems += "$f is a version this patch does not know"; continue }
    Say "  $f - ok ($($row.patch))"
    $plan += $row
}
if ($problems.Count) {
    Say ''
    Say 'Nothing was changed, because:' 'Red'
    $problems | ForEach-Object { Say "  - $_" 'Red' }
    Say 'This patch needs the klesun English patch 1.04.20 installed first (Rance10.ain, Rance10EX.ex, Rance10Pact.afa),' 'Yellow'
    Say 'and Rance10CG2.afa / Rance10Flat.afa either original or from the klesun links. See README for details.' 'Yellow'
    Done 1
}
if (-not $plan.Count) { Say ''; Say 'Everything is already patched.' 'Green'; Done 0 }

$bak = Join-Path $GameDir '_EnglishRevision_backup'
New-Item -ItemType Directory -Force -Path $bak | Out-Null
foreach ($row in $plan) {
    $f = $row.file; $path = Join-Path $GameDir $f; $tmp = "$path.new"
    Say ''
    Say "Patching $f ..." 'Cyan'
    $b = Join-Path $bak $f
    if (-not (Test-Path $b)) { Copy-Item -LiteralPath $path -Destination $b }
    & $xd -d -f -s "$path" (Join-Path $pd $row.patch) "$tmp"
    if ($LASTEXITCODE -ne 0 -or -not (Test-Path $tmp)) { Say "  xdelta failed for $f; the file was not changed." 'Red'; Done 1 }
    $got = (Get-FileHash -Algorithm MD5 -LiteralPath $tmp).Hash
    if ($got -ne $row.target_md5) { Remove-Item $tmp -Force; Say "  Result check failed for $f; the file was not changed." 'Red'; Done 1 }
    Move-Item -LiteralPath $tmp -Destination $path -Force
    Say "  done" 'Green'
}
Say ''
Say 'All done. Your original files are in _EnglishRevision_backup inside the game folder; Restore.bat puts them back.' 'Green'
Done 0
