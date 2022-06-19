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

# teleport to here
func teleport_to_this(position_id):
	var teleportEnterPos = get_node_or_null("EnterPos")
	if teleportEnterPos:
		var position2D = teleportEnterPos.get_children()[position_id]
		player.global_position = position2D.position
		print("Player position set to " + str(player.global_position))

# teleport out from here
func _on_Teleport_switch_to(new_scene_path, position_id):
	get_parent().switch_to_scene(name, new_scene_path, position_id)
