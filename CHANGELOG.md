# Changelog

## v2.0.0 - 2026-11-25
Complete translation. **No longer needs klesun's patch**: the installer works on the plain Japanese 1.04 game, and
also upgrades klesun 1.04.20 or v1.0.0 / v1.1.0 of this patch in place.
- Story: the rest of the game retranslated from the Japanese (second half of Part 1, Part 2, Part 2 friendship
  events, After mode, Synopsis Mode), so the whole story (~270,000 lines) is now this translation. The adult scenes
  Claude doesn't translate (~33,500 lines) were translated with DeepSeek V4.1 Flash through Venice AI, with the same
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
