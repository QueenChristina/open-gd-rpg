extends Node2D

var scene_id_to_path = {
	"intro" : "res://Scenes/Introduction.tscn"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# TODO: autoload as main root world scene instead. and call this from Teleport, no signals needed.
func switch_to_scene(old_scene_name, new_scene_path, position_id):
	# Remove the current level
	var level = get_node(old_scene_name)
	call_deferred("remove_child", level)
	level.call_deferred("free")

	# Add the next level
	var next_level_resource = load(new_scene_path)
	var next_level = next_level_resource.instance()
	call_deferred("add_child", next_level)
	next_level.call_deferred("teleport_to_this", position_id)
