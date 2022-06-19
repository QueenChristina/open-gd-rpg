extends AnimationPlayer

onready var SAVE_KEY: String = "anim_player_" + name + "_Introduction"

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.connect("play_animation", self, "_on_play_animation")

func _on_play_animation(animation):
	print("Playing cutscene " + animation)
	self.play(animation)
	GameState.cutscene = true

func _on_animation_finished(_anim_name):
	GameState.cutscene = false

func save(save_game: Resource):
	save_game.data[SAVE_KEY] = {
		'animation' : self.current_animation
	}


func load(save_game: Resource):
	self.current_animation = save_game.data[SAVE_KEY]['animation']
