# open-gd-rpg
Open source basic J-RPG in Godot.

## Features
* [Player animations and movement as done by HeartBeast](https://www.youtube.com/watch?v=mAbG8Oi-SvQ&list=PL9FzW-m48fn2SlrW0KoLT4n5egNdX-W9a&index=1)
* Scene switching
* [Advanced dialog system](https://github.com/QueenChristina/gd_dialog)
* Inventory and Items system
* Leveling System (incomplete)
* Enemies/Monsters
* Save system (incomplete)
* Menu and settings (incomplete)

## How to Use
`utils`:
Instance the following to...:
* `TalkableItem.tscn`
Make a NPC that players can talk to, recieve quests, and give items to.
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

## Based on:
* [Heartbeast's action RPG tutorial](https://www.youtube.com/watch?v=mAbG8Oi-SvQ&list=PL9FzW-m48fn2SlrW0KoLT4n5egNdX-W9a&index=1)
* [GDQuest's Open RPG](https://github.com/GDQuest/godot-open-rpg)
