extends KinematicBody2D

export var direction = Vector2.UP
export var ACCELERATION = 360
export var MAX_SPEED = 100
export var FRICTION = 200
var velocity = Vector2.ZERO
onready var sprite = $Area2D/fire
onready var area = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _physics_process(delta):
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	if !GameState.is_paused():
		velocity = move_and_slide(velocity)
	sprite.rotation_degrees = atan2(direction.y, direction.x) * 180 / PI - 90
	area.knockback_vector = direction
