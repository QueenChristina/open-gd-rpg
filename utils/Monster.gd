# courtesy of HeartBeast https://www.youtube.com/watch?v=srQz4Ix8rZM
extends KinematicBody2D

var is_in_attack_range = false
var knockback = Vector2.ZERO
onready var stats = $Stats

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)

func _on_Eyesight_body_shape_entered(body_id, body, body_shape, area_shape):
	if body.is_in_group("Player"):
		is_in_attack_range = true

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 110

func _on_Stats_no_health():
	queue_free()
