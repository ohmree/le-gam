# le-gam
A single player 2D top-down MOBA-ARPG-RTS-ish game in Godot maybe?

[A barebones demo of the current features](https://kind-allen-64e733.netlify.com/)

[Previous demo with a few more features but less flexible architecture](https://nifty-shockley-f8406d.netlify.com/)

Controls: right click to move, left click to select attack target

## Still a ton to implement, but some of the basics are there:
 * Movement
 * ~~Ranged auto-attacks~~ need to reimplement
 * Health and attack damage (I guess?)

## Some things that I'll probably have to implement in this version of the game:
 * Abilities - think League of Legends but with one less ability and generally less complex
 * Melee auto-attacks
 * At least basic enemy hero AI
 * Minions, towers, bases, jungles, bosses - the full MOBA shebang.
 * A proper map - ideally something that resembles [Adventure Time Battle Party](https://adventure-time-battle-party.fandom.com/wiki/Adventure_Time_Battle_Party_Wiki)'s map but fully 2D instead of isometric-2.5D-rendered-in-full-3D-ish.
 * Health drops in specific places like ATBP had.
 * More heroes - I think I can get away with cloning ATBP's heroes but with different names and assets (and of course a different perspective).
 * More stats, preferably ones like ATBP had (maybe with different names if necessary).
 * Backpacks - loadouts that you can choose before a game, they consist of 5 items each and are suited for more-or-less specific playstyles. Every time you level up you can upgrade one item.
 * Experience - when you level up you get stronger (IIRC) and are able to upgrade an item from your backpack/loadout.
 * A full-fledged HUD - a minimap, a health bar of sorts, ability icons with cooldown indicators, status effect icons (only if ATBP implements those), a few markers you can place on the map to communicate with your teammates (for when I make it multiplayer)
 * Anything else that's required for fun, not-too-{long,complex}, 3v3 moba-ish gameplay.

## Some explicit non-goals:
 * Good looks (at least for now, I suck at art more than I do at programming and game design).
 * Teleportation to base.
 * 5v5.
 * 4 Abilities.
 * An in-game shop.
 * Consumables.
 * Mana or any other meter/bar that isn't health, experience/levels and cooldowns.
 * Any persistent buffs other than backpacks.
 * Generally things that make the game longer, more complex and less blitz-y, but it depends on the thing in question.
 * Probably anything that LoL does differently to ATBP (subject to change?). ATBP is a great example of minimalist design and that is what I'll be trying to follow in this project (to the best of my ability, I still suck at this).

## Goals for the far future, when I git gud™:
 * Implement multiplayer so this becomes an actual MOBA
 * Remake it in 3D, probably with Godot but it's not a 100% must. The end goal is to have an ATBP clone with the same heroes and gameplay, a similar art-style but completely different assets and lore because Cartoon Network owns the rights for Adventure Time.


Not much else to say, crappy code and unfinished garbage ahead.

If anyone who actually knows Godot sees this, I'd appreciate it if you could help me with some best organization/structure practices.
Current codebase isn't as much of a mess as it used to be, but there's still a lot of room for improvement.
