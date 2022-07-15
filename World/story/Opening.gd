extends Place

var done_tutorial = false
var SAVE_KEY = "Opening_Tutorial"

# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(0.5), "timeout") # So that load() happens before the tutorial starts and correctly updates done_tutorial
	if not done_tutorial:
		UI.start_dialog("hand_tutorial")
		done_tutorial = true

func save(save_game: Resource):
	save_game.data[SAVE_KEY] = {
		"done_tutorial" : done_tutorial,
	}

func load(save_game: Resource):
	if save_game.data.has(SAVE_KEY):
		var data : Dictionary = save_game.data[SAVE_KEY]
		done_tutorial = data["done_tutorial"]
