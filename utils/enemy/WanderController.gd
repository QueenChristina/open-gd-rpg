extends Node2D

# monster wanders around a certain area, and goes back to it
export(int) var wander_range = 200

onready var start_position = global_position
onready var target_position = global_position

onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	update_target_position()

func update_target_position():
	var target_vector = Vector2(rand_range(-1 * wander_range, wander_range), rand_range(-1 * wander_range, wander_range))
	target_position = start_position + target_vector
	
func get_time_left():
	return timer.time_left
	
func start_wander_timer(duration):
	timer.start(duration)
	
# get a new position to wander to every timeout
func _on_Timer_timeout():
	update_target_position()
	
