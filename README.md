# open-gd-rpg
Open source basic action J-RPG in Godot.

[Demo](https://qintin.itch.io/rpg-in-rpg)

## Features
* [Player animations, initial RPG, and movement as done by HeartBeast](https://www.youtube.com/watch?v=mAbG8Oi-SvQ&list=PL9FzW-m48fn2SlrW0KoLT4n5egNdX-W9a&index=1)
* Scene switching
* [Advanced dialog system](https://github.com/QueenChristina/gd_dialog)
* Inventory and Items system
* Enemies/Monsters
* Save system
* Menu and settings
* Quest System
  * Receive quest logs and rewards after talking to NPCs.
* Leveling Sytem
  * Gain experience points and level up as you fight monsters.

## How to Use
`utils`:
Instance the following to...:
* `TalkableItem.tscn`
Make a NPC that players can talk to, recieve quests, and give items to.
* `PickableItem.tscn`
Pick up an item with dialog
* `Loot.tscn`
Loot dropped by monsters, enters player inventory upon being near enough
* `Monster.tscn`
Make a monster that players can hit, kill, and recieve loot from.

`World\GeneralPlace.tscn`
Make a basic place scene that players can enter/exit.

`UI\save`
Save system using [GDQuest's system](https://www.youtube.com/watch?v=ML-hiNytIqE).

See [Advanced dialog system](https://github.com/QueenChristina/gd_dialog) for how the dialog system works.

## Basics of How it Works
Tree:
<pre>
World
|_Place (only one main Place scene instanced at a time)
  |_TileMap
  |_Camera
  |_YSort
  | |_Player
  | |_NPCs, Monsters, TalkableItems, Background objects
  | |_ ...
  |_EnterPos
  |_|_Position2D (points of entry to the place)
  |_|_...
  |_Teleport (areas of exit from the place to a new place)
  |_...
</pre>

`UI.tscn` with save menu and HP, EXP bars are autoloaded.

Game data and globals saved in `GameSrc/GameHandlers.tscn`.

Player stats (health, inventory) saved in autoloaded `PlayerStats.gd`.

To save something's data, add them to the `save` group, and add `save` and `load` functions to save their data to a `save_game.data` dictionary with their own unique key. You can specify how the game handles saving an object with these functions. Game saving handled by GDQuest's `GameSaver` system.

## Based on:
* [Heartbeast's action RPG tutorial](https://www.youtube.com/watch?v=mAbG8Oi-SvQ&list=PL9FzW-m48fn2SlrW0KoLT4n5egNdX-W9a&index=1)
* [GDQuest's Open RPG](https://github.com/GDQuest/godot-open-rpg)

## Credits
Leveling sound: https://freesound.org/people/qubodup/sounds/442943/

***
If you found this project useful, I'd love to know! Send me a link to your own game anytime, I'd love to check it out. :)