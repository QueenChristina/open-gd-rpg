extends TeleportArea

export var condition = "player inventory has sacred_amulet"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Teleport_body_shape_entered(_body_id, body, _body_shape, _area_shape):
	if body.is_in_group("Player") and Globals.is_condition_met(condition):
		print("conditional switching to scene " + new_scene_path + " at " + str(to_pos_id))
		print("TODO: load new scene and switch scenes. Save old scene depending on scene type.")
		
		emit_signal("switch_to", new_scene_path, to_pos_id)
		# https://godotengine.org/qa/7940/scene-switching-and-returning
		# https://www.reddit.com/r/godot/comments/gbrt9a/how_to_save_previous_scene_when_switching_scenes/ (option 3)
		# https://www.reddit.com/r/godot/comments/ccfgdw/how_would_you_go_about_loading_a_previous_scene/
		
		GameSaver.save(999) # TODO: a better temp save file name?
		# TODO: connect to new scene AND which area in scene to spawn to!
