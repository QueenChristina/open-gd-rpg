"""
Place
A place in the world, to be switched as main world scenes.
"""
extends Node
class_name Place

signal switch_to(old_scene, new_scene)

onready var player = $YSort/Player

func _ready():
	pass
	# TODO: save to packed scene w/ nodes instead (see: add to group, persistent)

# teleport to here
func teleport_to_this(position_id):
	var teleportEnterPos = get_node_or_null("EnterPos")
	if teleportEnterPos:
		GameSaver.load(997, true) # Save game to temp file when switching scenes
		
		var position2D = teleportEnterPos.get_children()[position_id]
		player.global_position = position2D.position
		print("Player position set to " + str(player.global_position))

# teleport out from here
func _on_Teleport_switch_to(new_scene_path, position_id):
	get_parent().switch_to_scene(name, new_scene_path, position_id)
