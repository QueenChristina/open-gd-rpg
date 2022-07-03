tool
# courtesy of HeartBeast https://www.youtube.com/watch?v=srQz4Ix8rZM
extends KinematicBody2D

export var ACCELERATION = 360
export var MAX_SPEED = 50
export var FRICTION = 200
export var loots = [] # droppable items other than money
export var experience = 5 # for the player to earn when killed
export var chance_of_loot = 0.3 # Chance of getting loot/money at all
export var level = 1 # level of the monster
export var mon_name = "Slime" setget set_name # name of monster

enum {
	IDLE,
	WANDER,
	CHASE
}

var is_player_in_sight = false
var player = null
var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
onready var sprite = $AnimatedSprite
onready var stats = $Stats
onready var hurtSound = $HurtSound
onready var softCollision = $SoftCollision
onready var modTimer = $Timer
onready var wanderController = $WanderController
onready var loot = preload("res://utils/Loot.tscn") # could be money or loot
onready var healthBar = $HealthBar
onready var labelName = $HealthBar/Label

var state = IDLE

# Called when the node enters the scene tree for the first time.
func _ready():
	labelName.text = mon_name
	healthBar.max_value = stats.max_health
	healthBar.value = stats.health
	healthBar.visible = false
	
func set_name(value):
	mon_name = value
	labelName.text = mon_name
	
func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			
			if wanderController.get_time_left() <= 0.01:
				update_wander()
		WANDER:
			seek_player()
			
			if wanderController.get_time_left() <= 0.01:
				update_wander()
				
				# move towards random target position
				accelerate_towards(wanderController.target_position, delta)
				
				# if close enough to target position, change state
				if global_position.distance_to(wanderController.target_position) <= MAX_SPEED * delta:
					state = pick_random_state([IDLE, WANDER])
		CHASE:
			if player != null:
				accelerate_towards(player.global_position, delta)
			else:
				state = IDLE
			
	if softCollision.is_colliding():
		# push away from other monsters
		velocity += softCollision.get_push_vector() * delta * 430
	velocity = move_and_slide(velocity)

func accelerate_towards(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0

func update_wander():
	state = pick_random_state([IDLE, WANDER])
	wanderController.start_wander_timer(rand_range(1, 3))

func seek_player():
	if is_player_in_sight:
		state = CHASE

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 110
	hurtSound.play()
	sprite.modulate = Color(100, 100, 100, 1)
	modTimer.start()
	healthBar.value = stats.health
	healthBar.visible = true
	
func _on_Timer_timeout():
	sprite.modulate = Color(1, 1, 1, 1)

func _on_Stats_no_health():
	hurtSound.play()
	spawn_loot()
	yield(hurtSound, "finished")
	queue_free()

func spawn_loot():
	PlayerStats.experience += experience
	# chance of loot, money, or nothing
	if randf() <= chance_of_loot:
		var new_loot = loot.instance()
		get_parent().call_deferred("add_child", new_loot)
		new_loot.global_position = global_position
		
		# TODO: set to be money or loot
		new_loot.item = "money"
		new_loot.amount = 1 # TODO: random amount
		new_loot.call_deferred("set_icon", load("res://Assets/Items/money.png"))

func _on_Eyesight_body_shape_entered(body_id, body, body_shape, area_shape):
	if body.is_in_group("Player"):
		is_player_in_sight = true
		player = body

func _on_Eyesight_body_shape_exited(body_id, body, body_shape, area_shape):
	is_player_in_sight = false
	player = null
	healthBar.visible = false
