# Rance X English Translation - patch installer
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

### game folder selection (same block in apply.ps1 and restore.ps1) ###
# Every folder that holds Rance10.exe: <drive>\Program Files (x86)\AliceSoft\*, ...\Program Files\AliceSoft\*,
# <drive>\AliceSoft\*, <drive>\Games\AliceSoft\* on every local drive, then the folder this package is in.
# REV_SEARCH_ROOTS (folders separated by ';') replaces the search list; it is only meant for testing.
function Find-Games {
    $bases = @()
    if ($env:REV_SEARCH_ROOTS) { $bases = @($env:REV_SEARCH_ROOTS -split ';' | Where-Object { $_ }) }
    else {
        foreach ($r in @(${env:ProgramFiles(x86)}, $env:ProgramFiles) | Where-Object { $_ }) { $bases += (Join-Path $r 'AliceSoft') }
        foreach ($d in [IO.DriveInfo]::GetDrives()) {
            try { if ($d.DriveType -ne 'Fixed' -or -not $d.IsReady) { continue } } catch { continue }
            foreach ($s in 'Program Files (x86)\AliceSoft', 'Program Files\AliceSoft', 'AliceSoft', 'Games\AliceSoft') { $bases += (Join-Path $d.RootDirectory.FullName $s) }
        }
        $bases += $root
    }
    $found = New-Object System.Collections.Generic.List[string]
    foreach ($b in $bases) {
        $dirs = @(Get-Item -LiteralPath $b -ErrorAction SilentlyContinue | Where-Object { $_.PSIsContainer })
        $dirs += @(Get-ChildItem -LiteralPath $b -Directory -ErrorAction SilentlyContinue)
        foreach ($d in $dirs) {
            $p = $d.FullName.TrimEnd([char]92)
            if ((Test-Path -LiteralPath (Join-Path $p 'Rance10.exe')) -and -not ($found | Where-Object { $_ -ieq $p })) { $found.Add($p) }
        }
    }
    return ,$found
}
function Browse-Game {
    try {
        Add-Type -AssemblyName System.Windows.Forms
        $dlg = New-Object System.Windows.Forms.FolderBrowserDialog
        $dlg.Description = 'Select the Rance X game folder (the one containing Rance10.exe)'
        if ($dlg.ShowDialog() -eq 'OK') { return $dlg.SelectedPath }
    } catch { Say "  (could not open the folder window: $($_.Exception.Message))" 'Yellow' }
    return ''
}
# Shows the folders found and lets the user accept (Enter), pick a number, type/paste a folder or browse.
# Unattended runs (REV_NOPAUSE) keep the old behaviour: first folder found, else the folder window.
function Choose-Game {
    $found = Find-Games
    if ($env:REV_NOPAUSE) { if ($found.Count) { return $found[0] }; return (Browse-Game) }
    $mark = { param($p) if (Test-Path -LiteralPath (Join-Path $p '_EnglishRevision_backup')) { '   (this patch was installed here before)' } else { '' } }
    Say ''
    if ($found.Count -eq 1) {
        Say 'Found the game here:'
        Say "  $($found[0])$(& $mark $found[0])" 'White'
        $ask = 'Press Enter to use this folder, or type/paste another game folder (B = browse, Q = quit)'
    } elseif ($found.Count -gt 1) {
        Say "Found $($found.Count) Rance X folders:"
        for ($i = 0; $i -lt $found.Count; $i++) { Say "  [$($i + 1)] $($found[$i])$(& $mark $found[$i])" 'White' }
        $ask = 'Type the number of the folder to use (Enter = 1), or type/paste another game folder (B = browse, Q = quit)'
    } else {
        Say 'Could not find the game folder by itself.' 'Yellow'
        $ask = 'Type/paste the game folder (the one with Rance10.exe), or press Enter to pick it in a window (Q = quit)'
    }
    for ($try = 0; $try -lt 10; $try++) {
        $a = Read-Host $ask
        if ($null -eq $a) { return '' }   # no more input
        $a = $a.Trim().Trim('"').Trim()
        if ($a -ieq 'q') { return '' }
        if ($a -eq '') { if ($found.Count) { return $found[0] }; $a = Browse-Game; if (-not $a) { continue } }
        elseif ($a -ieq 'b') { $a = Browse-Game; if (-not $a) { continue } }
        elseif ($a -match '^\d+$' -and $found.Count) {
            $n = [int]$a
            if ($n -ge 1 -and $n -le $found.Count) { return $found[$n - 1] }
            Say "  There is no number $a in the list." 'Yellow'; continue
        }
        if ((Test-Path -LiteralPath $a -PathType Container) -and (Test-Path -LiteralPath (Join-Path $a 'Rance10.exe'))) {
            return (Resolve-Path -LiteralPath $a).ProviderPath.TrimEnd([char]92)
        }
        Say "  No Rance10.exe in '$a'. Choose the folder that contains Rance10.exe." 'Yellow'
    }
    return ''
}
### end of game folder selection ###

Say '=== Rance X English Translation - installer ===' 'Cyan'
if (-not $GameDir) { $GameDir = Choose-Game; if (-not $GameDir) { Say 'No game folder chosen - nothing was changed.' 'Yellow'; Done 1 } }
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
        if (-not (Test-Path $b)) { $problems += "$f is from $($prev.version) of this patch, but its backup in _EnglishRevision_backup is missing"; continue }
        $src = $b; $md5 = Md5 $b; $how = "update from $($prev.version), using the backup"
    }
    $steps = Chain $f $md5
    if ($null -eq $steps) { $problems += "$f is a version this patch does not know"; continue }
    if (-not $how) {
        $p0 = $steps[0].patch
        $how = if ($p0 -like '*.klesun-to-original.xdelta') { 'klesun 1.04.20 file' }
               elseif ($p0 -like '*.legacy.xdelta') { 'older English patch file' } else { 'original 1.04 file' }
    }
    Say "  $f - ok ($how)"
    $plan += [pscustomobject]@{ file = $f; src = $src; steps = $steps }
}
if ($problems.Count) {
    Say ''
    Say 'Nothing was changed, because:' 'Red'
    $problems | ForEach-Object { Say "  - $_" 'Red' }
    Say 'This patch works on the Japanese Rance X 1.04 files (untouched, or with klesun''s English patch 1.04.20,' 'Yellow'
    Say 'or with an earlier version of this patch). If a file was changed by something else, put the original back' 'Yellow'
    Say '(for example by reinstalling the game) and run Install.bat again. See the README for details.' 'Yellow'
    Done 1
}
if (-not $plan.Count) { Say ''; Say 'Everything is already patched.' 'Green'; Done 0 }

# Everything below runs in three phases so that a failure never leaves a mixed install:
#   1. build every result into <game folder>\_er_work and check its MD5 (the game files are not touched)
#   2. back up the originals to _EnglishRevision_backup
#   3. move the results into place; if that fails part-way, put the already-moved files back from the backup
# xdelta3 is only ever given plain ASCII relative names (it reads paths through the ANSI code page, so a Japanese or
# accented folder name such as the default Japanese game folder name became ???10; GitHub #69): it runs with the game folder as its current
# folder, the patch is copied to _er_work\p.xd, and the folder names it sees are _er_work / _EnglishRevision_backup.
$work = Join-Path $GameDir '_er_work'
function Clean-Work { Remove-Item -LiteralPath $work -Recurse -Force -ErrorAction SilentlyContinue }
function Fail($msg) { Clean-Work; Say "  $msg" 'Red'; Say '  No game file was changed.' 'Red'; Done 1 }
Clean-Work
New-Item -ItemType Directory -Force -Path $work | Out-Null
$results = @()
$oldCwd = [Environment]::CurrentDirectory
try {
    [Environment]::CurrentDirectory = $GameDir; Set-Location -LiteralPath $GameDir
    $k = 0
    foreach ($p in $plan) {
        $f = $p.file; $k++
        Say ''
        Say "Preparing $f ..." 'Cyan'
        # source as a relative name: a file in the game folder, or its copy in the backup folder
        $srcFull = (Resolve-Path -LiteralPath $p.src).ProviderPath
        $inRel = $srcFull.Substring($GameDir.TrimEnd([char]92).Length + 1)
        $n = 0; $tmp = @()
        foreach ($s in $p.steps) {
            $n++
            $outRel = "_er_work\f$k.$n"
            Copy-Item -LiteralPath (Join-Path $pd $s.patch) -Destination (Join-Path $work 'p.xd') -Force
            & $xd -d -f -s $inRel '_er_work\p.xd' $outRel
            if ($LASTEXITCODE -ne 0 -or -not (Test-Path -LiteralPath $outRel)) { Fail "xdelta failed for $f." }
            if ((Md5 $outRel) -ne $s.target_md5) { Fail "Result check failed for $f." }
            if ($tmp.Count) { Remove-Item -LiteralPath $tmp[-1] -Force }
            $tmp += $outRel; $inRel = $outRel
        }
        $results += [pscustomobject]@{ file = $f; new = $inRel; src = $p.src }
    }
} catch { Fail "Unexpected error: $($_.Exception.Message)" }
finally { [Environment]::CurrentDirectory = $oldCwd }

# phase 2: back up the originals (a file that is already in the backup folder is never overwritten)
try {
    New-Item -ItemType Directory -Force -Path $bak | Out-Null
    foreach ($r in $results) {
        $path = Join-Path $GameDir $r.file; $b = Join-Path $bak $r.file
        if ($r.src -eq $path -and -not (Test-Path -LiteralPath $b)) {
            New-Item -ItemType Directory -Force -Path (Split-Path -Parent $b) | Out-Null   # files in subfolders (Movie\)
            Copy-Item -LiteralPath $path -Destination $b
            if ((Md5 $b) -ne (Md5 $path)) { throw "backup copy of $($r.file) does not match" }
        }
    }
} catch { Fail "Could not make the backup: $($_.Exception.Message)" }

# phase 3: move everything into place
$moved = @()
try {
    foreach ($r in $results) {
        $path = Join-Path $GameDir $r.file
        Move-Item -LiteralPath (Join-Path $GameDir $r.new) -Destination $path -Force
        $moved += $r
        Say "  $($r.file) - patched" 'Green'
    }
} catch {
    Say "  Could not put the new files in place: $($_.Exception.Message)" 'Red'
    Say '  Putting the old files back ...' 'Yellow'
    foreach ($r in $moved) {
        try { Copy-Item -LiteralPath (Join-Path $bak $r.file) -Destination (Join-Path $GameDir $r.file) -Force } catch { Say "  could not restore $($r.file); run Restore.bat" 'Red' }
    }
    Clean-Work
    Say '  The game files were put back as they were.' 'Red'
    Done 1
}
Clean-Work
Say ''
Say 'All done. The files as they were before are in _EnglishRevision_backup inside the game folder; Restore.bat puts them back.' 'Green'
Done 0
