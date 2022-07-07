extends Monster

# shooter style monster
onready var fireball = preload("res://Assets/Monsters/Fireball.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_FireballTimer_timeout():
	var fire = fireball.instance()
	self.add_child(fire)
	fire.direction = global_position.direction_to(PlayerStats.player_position) # starting point to other point
