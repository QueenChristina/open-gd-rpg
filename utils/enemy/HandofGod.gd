extends Monster

onready var timerCrush = $TimerCrush
var target_position = Vector2.ZERO
var sky_pos = Vector2(0, -400)
var waiting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _physics_process(delta):
	sky_pos = Vector2(self.position.x, 0)
	if state == CHASE and global_position.distance_to(target_position) <= 40:
		print("Set to idle")
		state = IDLE
		waiting = false
	if !waiting and state == IDLE and global_position.distance_to(sky_pos) <= 40:
#		timerCrush.start(rand_range(1, 3))
#		print("started timer")
#		waiting = true
		state = CHASE
	match state:
		IDLE:
			accelerate_towards(sky_pos, delta)
		CHASE:
			accelerate_towards(target_position, delta)

func _on_TimerCrush_timeout():
	target_position = PlayerStats.player_position
	state = CHASE
	print("Set to chase")
