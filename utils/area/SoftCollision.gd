extends Area2D

# Push away from colliding areas so monsters stay spaced apart

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func is_colliding():
	var areas = get_overlapping_areas()
	return areas.size() > 0

# Move in direction that separates the colliding area
func get_push_vector():
	var areas = get_overlapping_areas()
	var push_vector = Vector2.ZERO
	if is_colliding():
		var area = areas[0] # arbitrarily choose the first area to push away from
		push_vector = area.global_position.direction_to(global_position)
		push_vector = push_vector.normalized()
	return push_vector
