# courtesy of HeartBeast https://www.youtube.com/watch?v=srQz4Ix8rZM
extends KinematicBody2D

export var ACCELERATION = 360
export var MAX_SPEED = 50
export var FRICTION = 200
export var loots = []

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

var state = IDLE

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
		WANDER:
			pass
		CHASE:
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			else:
				state = IDLE
			sprite.flip_h = velocity.x < 0
			
	velocity = move_and_slide(velocity)

func seek_player():
	if is_player_in_sight:
		state = CHASE

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 110
	hurtSound.play()

func _on_Stats_no_health():
	hurtSound.play()
	spawn_loot()
	yield(hurtSound, "finished")
	queue_free()

func spawn_loot():
	pass

func _on_Eyesight_body_shape_entered(body_id, body, body_shape, area_shape):
	if body.is_in_group("Player"):
		is_player_in_sight = true
		player = body

func _on_Eyesight_body_shape_exited(body_id, body, body_shape, area_shape):
	is_player_in_sight = false
	player = null
