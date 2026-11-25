# Dialogue comparisons

Side-by-side examples of the story text: the Japanese original, the machine translation this project started
from (klesun's [rance-10-gpt-mtl](https://github.com/klesun/rance-10-gpt-mtl) 1.04.20, sentence-by-sentence GPT), and
this patch. Each row is one text box as the player sees it. All examples come from the **Prologue**, so they don't
spoil anything past the first hour of the game.

Generated from the game files with `tools/compare_md.py` (the m[] ids are in the HTML comments of this file).

- [1. Lines from a different conversation](#1-lines-from-a-different-conversation)
- [2. Lines shifted by one](#2-lines-shifted-by-one)
- [3. Rance sounding like Rance](#3-rance-sounding-like-rance)
- [4. The opening scene](#4-the-opening-scene)
- [5. Dialects](#5-dialects)
- [6. Banter and timing](#6-banter-and-timing)
- [7. Honorifics and forms of address](#7-honorifics-and-forms-of-address)
- [8. Names and verbal tics](#8-names-and-verbal-tics)

## 1. Lines from a different conversation

The Prologue briefing. In the old machine translation, several lines in this scene were replaced by lines from
somewhere else entirely (a defence plan and a summit meeting), so Rance answers "...Why?" with a sentence about
garrisons, and the briefing loses its key line. The translation was done line by line, and the lines got out of step
with the script. This patch translates whole scenes against the Japanese, so every box says what the Japanese says.

<!-- m 130766-130778 -->
| Speaker | Japanese | Previous fan patch (klesun MTL) | This patch |
|---|---|---|---|
| Sill | 「あのー…… 何があったのか、私達まだサッパリで……」 | "Um..." we still have no clue what happened..." | "Um... We still have no idea what happened..." |
| Rance | 「そうだ、いい加減に説明しろ説明」 | In that case, we have no choice but to rely on the local defense garrisons... | "Yeah, enough already, explain." |
| Crook | 「そうですね……」 | "Yes..." | "I see..." |
| Crook | 「では、私の口から説明させて頂きます」 | "Then, allow me to explain from my side." | "Then, allow me to explain." |
| Crook | 「今、人類国家は滅亡の危機に瀕しています」 | "Right now, the human nations are facing the brink of extinction." | "Right now, the nations of humanity are facing the threat of extinction." |
| Rance | 「…………何故だ？」 | Whatever happens, we must hold and defend Rance Castle | "......Why?" |
| Crook | 「LP7年9月17日、今から二週間ほど前、 魔人ケイブリス率いる魔軍の大軍団が 攻めてきました」 | until the summit meeting concludes. a massive Monster Army led by the Fiend lord Kayblis attacked." | "On September 17th, LP7, about two weeks ago, a great army of the Monster Army led by the Fiend Kayblis attacked." |
| Crook | 「地図をご覧下さい」 | Indeed. This summit is of paramount importance | "Please look at the map." |
| Crook | 「リーザス、ゼス、ヘルマン、自由都市、 ランスもご存じの四つの大国が同時に攻め込まれました」 | for the future of humanity. which even Rance knows of - were attacked simultaneously." | "Leazas, Zeth, Helman, the Free Cities... The four great nations you know, Rance, were invaded at the same time." |

## 2. Lines shifted by one

Same cause, smaller symptom: from Lia's second line on, every box in the old text shows the line *after* the one the
character is speaking, so Magic says Lia's "Perfect timing!" and the last box answers something nobody said.

<!-- m 131500-131510 -->
| Speaker | Japanese | Previous fan patch (klesun MTL) | This patch |
|---|---|---|---|
| Rance | 「うーん、そう言われてもなあ……」 | "Hmm, even if you say that..." | "Hmm, even if you put it that way..." |
| Lia | 「あ、ダーリン！？」 | "Ah, darling!?" "Hey, wait!" | "Oh, Darling?!" |
| Magic | 「あ、ちょっと！」 | "Just perfect timing! | "Hey, wait!" |
| Lia | 「ちょーど良かった！ 今日来たのはダーリンに会いたかったからなの」 | I came today because I wanted to see you, Darling." "So, Darling. | "Perfect timing! I came today because I wanted to see you, Darling." |
| Lia | 「さ、ダーリン。 リアと一緒にリーザス城に行きましょ？ こんな所にいるよりよっぽど安全よ♪」 | Let's go to Leazas Castle with Lia, shall we? "It'll be far safer there than in a tiny place like this! ♪" "H-hey, wait a minute! | "Come on, Darling. Let's go to Leazas Castle together, okay? It's way safer than being in a place like this♪" |
| Magic | 「ちょ、ちょっと！ どさくさになに言ってるのよ！」 | "What are you trying to pull in the middle of all this chaos!?" "B-Besides, Rance was supposed to marry me in the first place!" | "H-Hey! What are you saying, taking advantage of the chaos!" |
| Magic | 「だ、大体ランスは、元々私と結婚する筈で……」 | "Ah, enough with all this noisy mess." | "A-And anyway, Rance was originally supposed to marry me..." |

## 3. Rance sounding like Rance

Translations that are correct line by line can still read flat. Rance is rude, lazy and sure of himself; the old
text has him say "become my subordinates" and "You just have to obey". Character voices in this patch are modelled
on the official English releases of the earlier Rance games (MangaGamer), read by the translator for every character
before translating their scenes.

<!-- m 131529-131546 -->
| Speaker | Japanese | Previous fan patch (klesun MTL) | This patch |
|---|---|---|---|
| Rance | 「ちっ…… 馬鹿馬鹿しい、大使なんてヤメだ、ヤメ」 | "Tch..." "How ridiculous, I'm quitting this ambassador thing, quitting." | "Tch... Stupid. Forget being an ambassador, forget it." |
| Kouhime | 「ええっ！？ そ、そんな――」 | "Eh!? N-No way-" | "What?! B-But that's―" |
| Rance | 「ふん、ダメダメ。 こいつら俺の言うことなんて聞きゃしねぇ」 | "Hmph, no good, no good. These guys won't listen to what I say." | "Nope, no good. These guys won't listen to a word I say." |
| Rance | 「大体、大使だか外交官だが知らんが、 俺が皆に協力を呼びかける…… なんてのがはなから間違いなんだ」 | "Anyway, I don't care if I'm an ambassador or diplomat, calling everyone to cooperate- was a mistake from the start." | "Ambassador, diplomat, whatever, me calling on everyone to cooperate... that's wrong from the get-go." |
| Rance | 「だから、その代わり――」 | "So instead- | "So instead―" |
| Rance | 「俺が世界のトップに立ってやる」 | I'll take the top position in the world." | "I'll take the top spot in the world." |
| Magic | 「え……？」 | "Eh...?" | "Huh...?" |
| Rance | 「この場にいる奴ら全員、 今日から俺様の部下になれ」 | "Everyone here, starting today, become my subordinates." | "Everyone in this room, as of today you work for me." |
| Rance | 「誰が何をすればいいかは、 これからぜーんぶ、俺様が指示してやる。 お前らはそれに従うだけでオーケ」 | "Who does what, I'll give all the orders from now on. You just have to obey." | "From here on, I'll tell you every last thing about who does what. All you gotta do is follow orders. Easy." |
| Rance | 「そうしたら、魔軍なんぞ俺様が潰してやる」 | "Then, I'll crush that Monster Army myself." | "Then I'll crush the Monster Army or whatever." |
| Rance | 「がははは！ | "Gahahaha! | "Gahaha! |

## 4. The opening scene

The first lines of the game. The old text is mostly fine here; the changes are the small things that add up over
250,000 lines: Sill calls him "Master Rance" (as in the official English releases, not "Lord Rance"), Rance reading the
diary aloud is marked as a quote, and the stutters and drawn-out cries follow the Japanese.

<!-- m 128989-128996 -->
| Speaker | Japanese | Previous fan patch (klesun MTL) | This patch |
|---|---|---|---|
| Rance | 「おいシィル、何を書いてる」 | "Hey Sill, what are you writing?" | "Hey, Sill. What're you writing?" |
| Sill | 「きゃっ！ ランス様！？」 | "Eek! Lord Rance!?" | "Eek! Master Rance?!" |
| Rance | 「あ〜？ なになに？ 私達が巨大戦艦の中に入って……」 | "Huh? What is it? We entered the giant battleship..." | "Hmmm? What've we got here? 'Since we went inside the giant battleship...'" |
| Sill | 「きゃー！ ランス様、やめ、やめて下さい〜！」 | "Kyaa! Lord Rance, stop, please stop!" | "Eeeek! Master Rance, st-stop, please stoooop!" |
| Rance | 「ふん、日記か。 お前もマメだな」 | "Hmph, a diary, huh. You're quite diligent, aren't you?" | "Hmph, a diary, huh? You sure are diligent." |
| Rance | 「休憩は終わりだ、行くぞ」 | "Break's over, let's go." | "Break's over. Let's go." |

## 5. Dialects

Rocky speaks a rural dialect (おら, ～だす). The old text turns it into standard English; this patch keeps it as a
light country voice, the way the official translations handle it.

<!-- m 130161-130169 -->
| Speaker | Japanese | Previous fan patch (klesun MTL) | This patch |
|---|---|---|---|
| Rocky Bank | 「こんな場所で、ボーッとしてたら 何かまずいような……」 | "If we just stand around and zone out in a place like this, we're gonna end up in serious trouble..." | "If I just sit around zonin' out in a place like this, somethin' bad might happen..." |
| Bezeleye | 「なら、外に出てみたら？ ランス君達はまだ出てこないようだし」 | "Then why not go outside? It's not like Rance and his group are coming out anytime soon anyway." | "Then why not go outside? Rance and the others don't seem to be coming out anyway." |
| Rocky Bank | 「……そうだすな。 おら、人の多そうな街にでも行ってみるだす」 | "...Yes, that's right. "Yeah... I think I'll head out and find a town that seems busy." | "...I reckon so. I'll go see if there's some town with lots of folks." |
| Bezeleye | 「街ね。なら男の子モンスターを 探す私とは目的地は合わないわね」 | "A town? Well, my goal of hunting down boy monsters means our destinations won't match up." | "A town, hm. Then, I'm looking for boy monsters, so we won't be going the same way." |
| Rocky Bank | 「途中まで一緒に行くだ」 | "But I'll walk with you part of the way!" | "I'll go along with ya part of the way." |

## 6. Banter and timing

Chaos, the talking sword, calls Rance 心の友, which every official English release translates as "my kindred
spirit". The old text renders it word for word as "the heart's friend". Rance's comeback is cut off mid-insult in the Japanese, which the old text
replaced with a generic line.

<!-- m 133208-133214 -->
| Speaker | Japanese | Previous fan patch (klesun MTL) | This patch |
|---|---|---|---|
| Rance | 「がははは、その通り。 俺がいなきゃただの棒きれだってこと忘れるな」 | "Gahahaha, that's right. Don't forget that without me, it's just a stick." | "Gahahaha, exactly. Don't forget, without me you're just a stick." |
| Chaos | 「逆逆。 心の友だって儂がいなくちゃあ、 戦うことすら出来ないじゃないの」 | "No, no, the opposite. Even the heart's friend can't fight without me, you know." | "Wrong, wrong. Even you, my kindred spirit, without me can't even fight, can ya?" |
| Rance | 「なんだと？ 俺様をお前みたいな――」 | "What did you say? How dare you talk to me like that-" | "What? Comparing me to the likes of you―" |
| Cream | 「んっ、んんっ！ | "Nn, nn! | "Ahem! Ahem! |

## 7. Honorifics and forms of address

Japanese titles are translated the way the official English releases do it, instead of being left in romaji
("Okami-san" for 女将, the proprietress). Numbers use English digit grouping.

<!-- m 134853-134860 -->
| Speaker | Japanese | Previous fan patch (klesun MTL) | This patch |
|---|---|---|---|
| Atago McCart | 「全員で2000人ほどいるらしいけど、 そのうちの一部をうちで面倒見るようにって……」 | "Apparently there are about 2000 in total, and we're supposed to look after part of them..." | "There are about 2,000 of them in all, and he told me to look after some of them here..." |
| Atago McCart | 「うちは行き場のない人を 迎え入れる場所じゃないってのに……」 | "Our place isn't meant to be a refuge for people with nowhere to go... but here we are..." | "This place isn't a shelter for people with nowhere to go..." |
| Tama | 「まー、いいんじゃないっすかね。 CITYも避難する人大勢いてすっかり 寂しくなってたところですし」 | "Well, I guess it's fine. There are a lot of evacuees in CITY, and it's become quite quiet too." | "Well, I don't think it's so bad. Cidade's gotten all lonely with so many people evacuating, you know." |
| Kalar | 「女将さん、宜しくお願いしまーす」 | "Okami-san, thank you in advance!" | "Ma'am, we're in your care!" |

## 8. Names and verbal tics

Names and terms follow the [AliceSoft Wiki](https://alicesoft.miraheze.org) throughout (the alien Horus were
"Holses" in parts of the old text). The Horus end their sentences with ﾇﾇﾇ, which the old text wrote as a stage
direction ("*Nunununu*"); here it is part of the line, the same way every time.

<!-- m 129986-129995 -->
| Speaker | Japanese | Previous fan patch (klesun MTL) | This patch |
|---|---|---|---|
| Megas Horus | ホルスの女王のことじゃ。ﾇﾇﾇ」 | the queen of the Holses. Nunununu." | is the queen of the Horus. Nununu." |
| Rance | 「女王？」 | "A queen?" | "Queen?" |
| Megas Horus | 「うむ、儂らにとっては神にも等しく、 その美しさはあらゆる種族を越える……ﾇﾇﾇ」 | "Indeed. To us, she is nothing short of a divine goddess, and her transcendent beauty surpasses all racial boundaries..." *Nunununu* | "Indeed. To us she is equal to a god, and her beauty surpasses that of every race... Nununu." |
| Megawas Horus | 「と、思うのは、あくまでホルスの価値観。 人間が実際に目の当たりにしても なんの感動もないでしょうねぇ。ﾇﾇﾇ」 | "At least, that's the Horus perspective. Even if a human were to gaze upon her directly, they likely wouldn't feel the slightest bit of appreciation." *Nunununu* | "Well, that's only the Horus view, of course. I doubt a human who actually laid eyes on her would feel any wonder at all. Nununu." |
| Rance | 「……だな。 ムシ異星人のメスったって、 皆、お前みたいなもんだろう？」 | "...Indeed. "Exactly. Even if there's a female insect alien, she'd probably look just like a bug, wouldn't she?" | "...Yeah, probably. Bug alien females or whatever, they're all like you, right?" |

