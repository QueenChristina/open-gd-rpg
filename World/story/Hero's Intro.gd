extends Node

onready var anim_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_player.play("Intro")
#	yield(anim_player, "animation_finished")
	UI.hide()
	yield(get_tree().create_timer(2.5), "timeout")
	UI.start_dialog("intro")
	yield(UI, "dialog_ended")	
	UI.show()
	get_parent().switch_to_scene(name, "res://World/story/Opening.tscn", 1)
