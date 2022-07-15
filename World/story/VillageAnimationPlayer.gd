extends "res://utils/AnimationPlayer.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func ending():
	UI.start_dialog("ending")
	self.stop()
	yield(UI, "dialog_ended")
	GameState.cutscene = true # Permanently pause the game.
