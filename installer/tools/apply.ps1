# Rance X English Revision - patch installer
# Patches the game files of the Japanese Rance X 1.04 with xdelta, after checking that every file is a version the
# patch knows. Accepted starting points per file:
#   - the original Japanese 1.04 file (the normal case; no other patch is needed)
#   - the file from klesun's rance-10-gpt-mtl 1.04.20 (turned back into the original first, then patched)
#   - a file written by an earlier release of this patch (the copy in _EnglishRevision_backup is used as the start)
# Files are copied to <game folder>\_EnglishRevision_backup before the first change (Restore.bat puts them back).
param([string]$GameDir = '', [switch]$Elevated)
$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$root = Split-Path -Parent $here
$xd = Join-Path $here 'xdelta3.exe'
$pd = Join-Path $root 'patches'

function Say($t, $c = 'Gray') { Write-Host $t -ForegroundColor $c }
function Done($code) { Write-Host ''; if (-not $env:REV_NOPAUSE) { Read-Host 'Press Enter to close' }; exit $code }
function Md5($p) { (Get-FileHash -Algorithm MD5 -LiteralPath $p).Hash }

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

$rows = @(Import-Csv (Join-Path $pd 'manifest.csv'))
$old = @(Import-Csv (Join-Path $pd 'old.csv'))
$bak = Join-Path $GameDir '_EnglishRevision_backup'

# The final file is the target of the "<file>.xdelta" row (original -> this release).
function Final-Md5($f) { ($rows | Where-Object { $_.file -eq $f -and $_.patch -eq "$f.xdelta" } | Select-Object -First 1).target_md5 }
# Patch rows that lead from $md5 to the final file (at most two: klesun -> original -> final), or $null.
function Chain($f, $md5) {
    $final = Final-Md5 $f
    $steps = @()
    for ($i = 0; $i -lt 3; $i++) {
        if ($md5 -eq $final) { return ,$steps }
        $r = $rows | Where-Object { $_.file -eq $f -and $_.source_md5 -eq $md5 } | Select-Object -First 1
        if (-not $r) { return $null }
        $steps += $r; $md5 = $r.target_md5
    }
    return $null
}

$files = $rows | Select-Object -ExpandProperty file -Unique
$plan = @(); $problems = @()
Say ''
Say 'Checking game files (this takes a minute for the large archives)...'
foreach ($f in $files) {
    $path = Join-Path $GameDir $f
    if (-not (Test-Path $path)) { $problems += "$f is missing"; continue }
    $md5 = Md5 $path
    if ($md5 -eq (Final-Md5 $f)) { Say "  $f - already up to date"; continue }
    $src = $path; $how = ''
    $prev = $old | Where-Object { $_.file -eq $f -and $_.md5 -eq $md5 } | Select-Object -First 1
    if ($prev) {
        # written by an earlier release: start again from the file saved before that install
        $b = Join-Path $bak $f
        if (-not (Test-Path $b)) { $problems += "$f is from English Revision $($prev.version), but its backup in _EnglishRevision_backup is missing"; continue }
        $src = $b; $md5 = Md5 $b; $how = "update from $($prev.version), using the backup"
    }
    $steps = Chain $f $md5
    if ($null -eq $steps) { $problems += "$f is a version this patch does not know"; continue }
    if (-not $how) { $how = if ($steps.Count -gt 1) { 'klesun 1.04.20 file' } else { 'original 1.04 file' } }
    Say "  $f - ok ($how)"
    $plan += [pscustomobject]@{ file = $f; src = $src; steps = $steps }
}
if ($problems.Count) {
    Say ''
    Say 'Nothing was changed, because:' 'Red'
    $problems | ForEach-Object { Say "  - $_" 'Red' }
    Say 'This patch works on the Japanese Rance X 1.04 files (untouched, or with klesun''s English patch 1.04.20,' 'Yellow'
    Say 'or with an earlier English Revision). If a file was changed by something else, put the original back' 'Yellow'
    Say '(for example by reinstalling the game) and run Install.bat again. See the README for details.' 'Yellow'
    Done 1
}
if (-not $plan.Count) { Say ''; Say 'Everything is already patched.' 'Green'; Done 0 }

New-Item -ItemType Directory -Force -Path $bak | Out-Null
foreach ($p in $plan) {
    $f = $p.file; $path = Join-Path $GameDir $f
    Say ''
    Say "Patching $f ..." 'Cyan'
    $b = Join-Path $bak $f
    if ($p.src -eq $path -and -not (Test-Path $b)) { Copy-Item -LiteralPath $path -Destination $b }
    $in = $p.src; $n = 0
    foreach ($s in $p.steps) {
        $n++; $out = "$path.new$n"
        & $xd -d -f -s "$in" (Join-Path $pd $s.patch) "$out"
        if ($LASTEXITCODE -ne 0 -or -not (Test-Path $out)) { Say "  xdelta failed for $f; the file was not changed." 'Red'; Done 1 }
        if ((Md5 $out) -ne $s.target_md5) { Remove-Item $out -Force; Say "  Result check failed for $f; the file was not changed." 'Red'; Done 1 }
        if ($in -like "$path.new*") { Remove-Item -LiteralPath $in -Force }
        $in = $out
    }
    Move-Item -LiteralPath $in -Destination $path -Force
    Say "  done" 'Green'
}
Say ''
Say 'All done. The files as they were before are in _EnglishRevision_backup inside the game folder; Restore.bat puts them back.' 'Green'
Done 0
