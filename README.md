# Rance X English Revision

An improvement patch for the fan English translation of **Rance X -Showdown-** (AliceSoft, game version **1.04**).
It builds on klesun's [rance-10-gpt-mtl](https://github.com/klesun/rance-10-gpt-mtl) English patch and fixes and
extends it: translated images and maps, corrected names and terms, interface text, and a reviewed pass over the most
error-prone story lines.

> **18+ notice:** Rance X is an adult game sold to adults. This repository contains no game files, images or story
> text - only documentation and the installer scripts. The patch itself is in [Releases](../../releases).
> Please buy the game: [DLsite](https://www.dlsite.com/pro/work/=/product_id/VJ011759.html).

## What it changes

**Images (re-lettered from the Japanese originals)**
- All 40 Nunuhara memos and the 12 help screens, retranslated from the Japanese (the earlier versions were OCR +
  machine translation with many wrong names, swapped labels and unreadable text).
- 69 story maps: the world map in the opening and its variants, all regional and Monster Realm maps, and the campaign
  map overlays with commander name tags.
- About 50 more interface images: war-status maps (Monster Army), occupied-country stamps, Unit Bonus / Unit Rank,
  Interrupt Chance, EXP labels, ending-credit names, the Synopsis Mode / collection screens from the game's later
  update archives, and more.

**Interface and data**
- Around 1,400 interface and script strings that were still Japanese (speaker names, choices, battle logs, dialogs).
- Data tables: CG gallery and BGM titles, place names, achievements, all 4,414 character profile lines.
- Card names now show in English on item cards too, and long names fit their name plates.
- Smaller message-window font so translated lines fit.

**Story text**
- About 6,800 suspect lines reviewed against the Japanese: shifted or empty lines, mistranslations, wrong speakers.
- Dialogue quote marks follow the Japanese 「」 throughout (~40,000 lines).
- Character names and terms made consistent with the [AliceSoft Wiki](https://alicesoft.miraheze.org), and a bug in
  the old patch that turned "Sushinu" into "Sushinu the Gandhinu" (and similar) fixed.

The rest of the story text is still the original machine translation, so it can read flat in places.

## Requirements
1. Rance X updated to **version 1.04** (check `Version.txt` in the game folder; AliceSoft's update:
   <https://www.alicesoft.com/support/rance10.html>).
2. klesun's English patch **1.04.20** installed: replace `Rance10.ain`, `Rance10EX.ex` and `Rance10Pact.afa` in the
   game folder with the files from <https://github.com/klesun/rance-10-gpt-mtl/releases/tag/1.04.20>.
   (`Rance10CG2.afa` and `Rance10Flat.afa` can be either the game's originals or klesun's optional versions.)

## Install
1. Close the game.
2. Download `Rance10-English-Revision-v1.0.0.zip` from [Releases](../../releases) and unzip it anywhere.
3. Run `Install.bat`. It finds the game folder (or asks for it), asks Windows for administrator rights if the game
   is in Program Files, checks every file first, backs up the originals to `_EnglishRevision_backup` in the game
   folder, applies the patches and verifies the result. If any file is a version it doesn't know, it changes nothing
   and tells you which one.

Existing saves keep working and show the new text. To undo, run `Restore.bat`.

## Credits
- **klesun** and the contributors to [rance-10-gpt-mtl](https://github.com/klesun/rance-10-gpt-mtl) - the English
  translation this patch builds on, and its translated images.
- **nunuhara** - [alice-tools](https://github.com/nunuhara/alice-tools), used to unpack and rebuild the game files.
- The [AliceSoft Wiki](https://alicesoft.miraheze.org) - reference for character names and terms.
- [xdelta3](https://github.com/jmacd/xdelta-gpl) (Joshua MacDonald, GPL-2.0) - bundled in the release to apply the patches.
- **AliceSoft** - Rance X. This is an unofficial fan project, not affiliated with or endorsed by AliceSoft.

This revision was made with AI assistance (Anthropic's Claude): changes were checked against the Japanese text, but
mistakes are possible. Reports are welcome in [Issues](../../issues) (no spoilers in titles, please).

## License
The installer scripts and documentation in this repository are MIT-licensed (see `LICENSE`). The game, its text and
its art belong to AliceSoft; the base translation belongs to its authors.
