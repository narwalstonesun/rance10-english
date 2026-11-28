# Changelog

## v2.0.5 - 2026-11-28
Translation pass, map rework and fix rounds 2 and 3 (GitHub #46, #55, #57-#73). Installs over v2.0.4 (or anything
older) in place.

**Translation**
- Story-wide localisation pass: every story batch was read again against the Japanese. About 13,000 lines were
  rewritten: stiff, Japanese-shaped narration now reads as natural English, dialogue where a joke, idiom or set phrase
  was lost word for word says what the line actually does, and half-sentences lost where two Japanese lines had been
  merged are restored.
- Quest maps (#64): all captions and assistant idle lines (about 1,800 strings) retranslated from the Japanese.
- Card-get profile screen (#70, #71): all 670 character descriptions and the names and jobs retranslated from the
  Japanese; the skill line uses short "Skill LVn" terms and fits on screen.
- Names (#72): Japanese full names given name first everywhere, as in MangaGamer's releases, and card names spelled
  like the profiles and the story (381 story lines, 48 card names).
- Interface terms updated: Frigid Zone, Mortality Rate, Warfront Overview, Free Cities Zone, Morale,
  Squad, "Early Oct/LP 7" dates; 鬼 is "oni" as in the official Sengoku Rance; leftover "demon" wording in quest
  choices, quest lists and medals replaced (#63); 285 skill names redone from the Japanese.
- Text boxes (#58): the English kept the Japanese line breaks (two short lines, then a full one). Where a sentence
  continues onto the next line, it now runs on as one paragraph wrapped to the box width; a break after the end of a
  sentence stays. About 40,000 places, about 15,000 fewer lines; backlog, skip, voices and read-text marks work as
  before.
- Text added to the same box after a click is no longer glued to the previous text (#68, 291 places).

**Maps**
- The map lettering was refined to look nicer and painted into the maps instead of pasted on top: one classical serif in capitals and small caps, region names lettered along the banner scrolls, long
  names stacked instead of squeezed, ink and gold that take the paper's grain and tone, rivers and seas in the
  painted water lettering. This covers the 13 regional story maps, the parchment world maps, the turn map and its
  copies, the quest-table maps, the War Situation panels and the war-status map (#59).
- The title-screen map keeps its own art; only its lettering is replaced.
- War Situation panels (#73): names centred on their places, AliceSoft's painted captions (Fort of Banri, Tenmabashi)
  in English, half-erased Japanese cleaned up, the FALLEN stamp red and glowing like the Japanese one.
- The town by Rance Castle reads "Cidade" everywhere (#57); the leftover "A" next to Nippon on the war-status map is
  gone (#61).

**Interface**
- Menu buttons (#62): "Menu" in the game's own lettering, spaced like "Squad" and centred on the button, on the turn
  map, quest map, battle preparation and title screen.
- Long skill names wrap to two lines on card faces and battle skill buttons instead of running past the box (#66).
- Quest screen (#60): long place names no longer run over the "Location" label.
- The "Choice" caption no longer overlaps the panel ornament (#67); the "Meanwhile" scene-change caption is built the
  same way in every transition (#65).
- Quest list: long quest names wrap to two lines inside the button instead of running past it (#74).
- Quest info box: cleaner layout, every line flush left, "★ Difficulty Up", "Favored: Free Cities, Ice, Dark" (#75).
- Assistant speech bubble: letters no longer overlap (the Japanese letter spacing was too tight for English) (#76).
- Card profiles: the description stays inside the box (#77).
- Dark Rance's nameplate says "Dark Rance" (it said "Rance"), and the titles above nameplates no longer use
  brackets or colons ("Son of Feliss and Rance") (#78).
- Config (#55): the note under "Accelerate Skip Mode" names the "Skip Mode Speed" slider as it is labelled.

**Opening movie (#46)**: in the third movie the art behind the name tags comes from the game's own character images
instead of a synthesised fill (no more shimmer in the held shot before the fiend cards), the map behind the nation
tags keeps its moving stripes, single-frame jumps are smoothed, and two short moments that still showed Japanese (the
Helman wipe and one fast pan) are fixed.

**Installer (#69)**: works when the game folder has a Japanese or other non-English name (it failed with
"xdelta3: file open failed ... ???10"), and installs all or nothing: every file is patched and checked before any
is replaced, so a failure no longer leaves a half-patched game.

## v2.0.4 - 2026-11-26
Fix round from play-testing (GitHub #27, #30, #32-#53). Installs over v2.0.3 (or anything older) in place.
- **Crash fixed (#45):** the game closed by itself right after the war report at the end of turn 1 (every version
  since v2.0.1). The English number formatting added to the war report called an engine function the wrong way; it
  now formats numbers like the original code. Every other piece of game code the patch changes (41 functions) and
  the translated data were then checked by hand for anything similar; nothing else that could crash was found, and
  a build check now rejects this kind of mistake.
- Turn-end screen (#50): the monologue no longer loses every letter "r" (the game used "r" as its line-break
  marker), the header reads "(Turn 1) ended" and the death count shows the real number; the same fix applies to
  the item/bonus pop-ups on the quest map, battle-log lines keep their commas, and status descriptions are back to
  normal capitalisation.
- Text box (#49): the small title above the speaker's name plate is in English for every character (e.g. "Hero",
  not 勇者), with the wiki spellings.
- Quest result (#47): the "Total EXP" header is in English (it was still 累積EXP).
- Quest screens (#48): the date under the TURN medallion fits on screen (the "L" of "LP7" was cut off).
- Untranslated labels (#51): the playthrough-bonus panel title ("Playthrough Bonuses") and 16 more small labels
  drawn in stylised lettering (Seen, Unavailable, Achieved, CONFIRM, FALLEN, Alice's Mansion, ...).
- Quest-map choices (#52): texts like "Take care." show real spaces instead of hyphens.
- Card faces (#53): long affiliation names no longer overlap the label.
- Japanese left in data-driven text (#40): every place the game draws text from its data tables was traced; the
  rest (trophy names, secretary names, card names in dialogs, save comments, battle-log names, ...) is English.
- Maps: the old "Rising Dragon Mountain" text no longer shows twice on the war-status screens (#41), the Barao
  Mountains keep AliceSoft's own curved English label (#42), no blurred patch where an old label was erased (#43).
- Terminology (#44): JAPAN is called "Nippon" everywhere, as in the official English releases (text, maps, buttons).
- Battle screen: enemy unit names are in English also when the game adds a count or difficulty mark ("Weak
  Monsters (8)"), for every enemy (#30).
- Phase titles: the big-initial captions sit on the line like the Japanese (#34).
- Maps: the L·C·M Mountains keep AliceSoft's own painted English label along the range (#33).
- Smaller download: the Rance10Flat.afa patch is made against the official 1.04 file (about 84 MB instead of about
  900 MB); the download is about 1.1 GB instead of 1.7 GB (#35).
- Installer: shows the game folder it found and lets you accept it or type/pick another, with a numbered list when
  there are several copies; Restore asks the same way; `-GameDir` still works without questions (#36).
- Battle log: natural wording and normal punctuation ("took 1282 damage!" instead of "took 1282 of damage !"), the
  game's system terms, one message that was still Japanese translated; quest reward pop-ups cleaned up the same way (#37).
- Battle result: "Treasure Chance", "Final EXP" and "Total EXP" have a space between the words (#38).
- Title animation: -SHOWDOWN- appears at its final size and place during the logo reveal (#39).
- Opening movies (#27): the third movie's name cards and banners are styled like the Japanese lettering (outline, glow,
  bevel, texture) and the Japanese is removed without ghost strokes; its title card and end logo (-SHOWDOWN-) are in
  English; the narration in the first two movies types smoothly with per-letter fades, a lighter weight and an even
  glow. The ending movie is still Japanese.

## v2.0.3 - 2026-11-26
- Installer works on a clean Japanese 1.04 game (GitHub #31). Since v2.0.0 the patches had been made from five game
  files that came from an older English patch instead of AliceSoft's own 1.04 files, so a clean game was refused
  ("is a version this patch does not know" for Rance10.ain, Rance10EX.ex, Rance10Pact.afa, Rance10CG2.afa and
  Rance10Flat.afa). Patches are now made from the official files; games with the older files, klesun's patch or an
  earlier version of this patch still install and update.
- No translation changes since v2.0.2.

## v2.0.2 - 2026-11-25
- Prologue briefing: "a great army of the Monster Army" now reads "a huge Monster Army force" (GitHub #29). A
  story-wide check found no other place where a fixed term repeats its own word like this.
- Same installer as v2.0.1; installs over v2.0.1 (or anything older) in place.

## v2.0.1 - 2026-11-25
Fixes from play-testing v2.0.0 (GitHub issues #1-#26), plus the first translated movie. Installs over v2.0.0 in place.
- Opening movie (Part 1): the typed narration is in English, and the name cards / nation banners are re-lettered
  with the original motion. The ending movie is still Japanese.
- Place names: one spelling everywhere (maps, memos, story, data tables, interface), city names from the official
  English releases ("Siberia" / "Icefields", "Razir", "Kaizu" and similar fixed).
- Maps: place names on the strategy-screen maps (turn map, War Situation panels, war-status screen, quest maps) in
  English; map labels redrawn on the shape of the original lettering, evenly sized, sharp; region banners re-fitted.
- War-status screen: English date, commander names in English (also in older saves), the war report rewritten in
  full sentences, the "Human Army" header no longer runs into the army name.
- Battle: enemy and character names in attack pop-ups, the battle log and the HP bar in English; the battle-end,
  war-report and several more animated captions translated; animated captions move per letter, without dark borders.
- Quests: condition and reward lines, the favored affiliation, the prep quest header and "560,000"-style numbers fixed.
- Character card profiles fit the box (smaller font, re-wrapped, half-width digits).
- Text box: "--" shows as one long dash; the log viewer no longer cuts English lines off.
- Fixed: some sound effects, images, sprites and quest-map voice lines that didn't play because the original machine
  translation had translated the game's internal names for them.
- Fixed a few titles that didn't match the character's gender ("King" / "Emperor" for women).
- Installer: also patches the opening movies (Movie folder); Restore.bat puts those back too.

## v2.0.0 - 2026-11-25
Complete translation. **No longer needs klesun's patch**: the installer works on the plain Japanese 1.04 game, and
also upgrades klesun 1.04.20 or v1.0.0 / v1.1.0 of this patch in place.
- Story: the rest of the game retranslated from the Japanese (second half of Part 1, Part 2, Part 2 friendship
  events, After mode, Synopsis Mode), so the whole story (~270,000 lines) is now this translation. The adult scenes
  Claude doesn't translate (~33,500 lines) were translated with the uncensored/abliterated version of DeepSeek V4.1 Flash through Venice AI, with the same
  names, terms and character notes.
- Punctuation cleanup across the story: no invented dashes, colons or semicolons the Japanese doesn't have.
- Game-system terms unified across story, interface, cards, tutorials and images (EXP, Meal Ticket, Unit Bonus,
  Buff/Debuff, all 14 status names).
- Title screen: the logo subtitle is now -SHOWDOWN-, and the map behind the logo is re-lettered (~115 labels).
- Images: ending staff credits, the Friendship-5 badge, the redrawn Second Fiend War map, Nunuhara memo list
  thumbnails, the help screens and memos from the game's later update archives, tiny JAPAN province labels.
- Numbers shown in English style (35,000 instead of 3万5千), "Total Play Time", survey prompts.
- Installer: patches are made from the original Japanese files; klesun files are turned back into the originals first;
  older versions of this patch are updated from the backup made at their install.

## v1.1.0 - 2026-11-24
(Includes v1.0.1, which was never published separately.)
- Story revision, part 1: about 112,000 of the ~250,000 story lines retranslated from the Japanese (Prologue, the
  opening turns of Part 1, Nunuhara memo text and about half of Part 1's main story). Character voices follow the
  official English releases of earlier Rance games; names and terms follow the AliceSoft Wiki.
- Animated captions in English (scene-change "Meanwhile", war results, "Get!" captions, phase titles).
- English finisher name on the battle result screen; Encyclopedia / Achievements collection tabs translated.
- Fixed: some interface strings translated in v1.0.0 are also used by the game as internal keys, which broke card
  skill panels, unit-bonus and status icons, attack effects and similar. Those strings now stay Japanese internally
  and the English is shown on screen instead.
- Character names aligned with the AliceSoft Wiki in the story, character profiles and card names (e.g. Barres and
  Haurein Provence, Pigu Greciam, Rizna Lanfbit, Julia Lindam, Sel Curchgolf, Elenoa Ran, Miracle Tou, Ho-Raga).
- The last "Sushinu the Gandhinu" lines fixed (the old text had split the name across a line break).
- Installer: upgrades a v1.0.0 install directly; only refuses to run when the game is running from the folder being
  patched.

Known issues: some screens touched by the internal-key fix were checked in the code but not yet in play, so a label
there may show Japanese; the second half of Part 1 onward is still the original machine translation.

## v1.0.0 - 2026-11-23
First release. Requires Rance X 1.04 with klesun's English patch 1.04.20.

- Images: 40 Nunuhara memos and 11 help screens (still Japanese in the previous patch) translated; 69 story maps (world, regional,
  Monster Realm, campaign overlays); ~50 interface images (war-status maps, occupied stamps, Unit Bonus/Rank,
  Interrupt Chance, EXP labels, ending credits, Synopsis Mode and collection screens).
- Interface/data: ~1,400 remaining Japanese strings translated; CG gallery, BGM, place names, achievements and all
  character profile lines; English card names on item cards, long names fitted to the name plate.
- Story: ~6,800 suspect lines reviewed against the Japanese; quote marks follow the Japanese throughout; names and
  terms made consistent with the AliceSoft Wiki; over-expanded names from the old patch ("Sushinu the Gandhinu") fixed.

Known issues: a few tiny map labels and decorative text remain in Japanese; light smudges where text over artwork was
replaced; most story text is still the original machine translation.
