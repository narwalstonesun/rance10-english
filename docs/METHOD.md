# How it was made

A short description of the translation process, for anyone curious or anyone who wants to continue or check the
work. No story details.

## Starting point

The project began as a set of fixes on top of klesun's
[rance-10-gpt-mtl](https://github.com/klesun/rance-10-gpt-mtl) 1.04.20, a GPT machine translation done one sentence
at a time. v1.0.0 and v1.1.0 of this patch still required it. From v2.0.0 on, the whole story is retranslated
from the Japanese and the patch installs on the plain Japanese game; the old translation remains only as a reference
(and as the base of the build tooling).

## Story text

The story (about 270,000 lines, split into ~400 batches of about 700 lines, in play order) was translated by Claude
Sonnet working from the Japanese alone: apart from the first two pilot batches, the old machine translation was not
shown, so it could not be copied. What
the translator gets for each batch:

- **Whole scenes**, with the lines played just before the batch as context, instead of single sentences.
- **A house style** modelled on MangaGamer's official English Rance releases: honorifics translated the way those
  releases do ("Master Rance", "Lord X", "-dono" for old-fashioned speakers), "?!" and "--" punctuation, laughs and
  verbal tics as character marks ("Gahahaha!", ", nya"), third-person self-reference turned into "I".
- **A voice entry for every speaking character** (342 of them). For the ~60 characters who appear a lot in earlier
  official releases (Rance 01, 03, Sengoku Rance, Rance Quest Magnum, Rance IX), the entry is built from their
  official English lines, so they keep the voice MangaGamer gave them; the others get an entry from the Rance X
  Japanese and the [AliceSoft Wiki](https://alicesoft.miraheze.org).
- **Fixed names and terms**: character names, places and titles from the AliceSoft Wiki, and one set of game-system
  terms (EXP, Meal Ticket, Unit Bonus, Buff/Debuff, status names) shared with the interface and the images.
- **Everyone mentioned in the batch**, with their English name and sex, so titles and pronouns come out right for
  characters who are talked about but don't speak.

Every batch then goes through automatic checks before it is accepted: every line present and in its place, quote
marks mirroring the Japanese 「」, no Japanese left, no gendered title on the wrong character, address forms allowed by
the speaker's voice entry, terminology, punctuation. A second model (Claude) reviewed a sample of the batches against
the Japanese (the first batch of each part, every fifth batch, and any batch with doubts), and all accepted batches are
re-checked against the current rules before each build.

About 33,500 lines (adult scenes that Claude doesn't translate) were translated with DeepSeek V4.1 Flash through
Venice AI, given the same house style, voice entries, names and terms, then checked for structure (every line present
and in its place, no Japanese left) and run through the same house-style fixes.

## Images

Text inside images was found by OCR across every game archive, then each image was re-lettered: the Japanese
removed, the background repaired, and the English set in a matching font, size, colour and effect, with names taken
from the story text so maps and dialogue agree. Every image has a status in a checklist, so nothing is skipped by
accident. Painted scenery text (shop signs, banners) is left as it is, as the official releases do.

## Interface and game data

Some Japanese strings in the game code are also used as internal keys (file names, data lookups, the calendar). Those
stay Japanese inside the game and the English is drawn only on screen, so the game logic is untouched.

## Tools

The game files are unpacked and rebuilt with nunuhara's [alice-tools](https://github.com/nunuhara/alice-tools). The
release is a set of xdelta3 patches made against the original Japanese 1.04 files, with MD5 checks before and after
every step.
