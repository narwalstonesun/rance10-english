# Rance X English Translation - restore the files saved by the installer
param([string]$GameDir = '', [switch]$Elevated)
$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$root = Split-Path -Parent $here
function Say($t, $c = 'Gray') { Write-Host $t -ForegroundColor $c }
function Done($code) { Write-Host ''; if (-not $env:REV_NOPAUSE) { Read-Host 'Press Enter to close' }; exit $code }
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
Say '=== Rance X English Translation - restore ===' 'Cyan'
if (-not $GameDir) { $GameDir = Choose-Game }
if (-not $GameDir) { Say 'No game folder chosen - nothing was restored.' 'Yellow'; Done 1 }
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
$bakFull = (Resolve-Path -LiteralPath $bak).ProviderPath.TrimEnd([char]92)
Get-ChildItem -LiteralPath $bakFull -File -Recurse | ForEach-Object {   # includes subfolders (Movie\)
    $rel = $_.FullName.Substring($bakFull.Length + 1)
    Copy-Item -LiteralPath $_.FullName -Destination (Join-Path $GameDir $rel) -Force
    Say "  restored $rel" 'Green'
}
Say 'Done. The backup folder was kept; delete it yourself if you no longer need it.' 'Green'
Done 0
