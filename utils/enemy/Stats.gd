extends Node

export(int) var max_health = 30
onready var health = max_health setget set_health # if max_health is updated in editor, this updates on ready

signal no_health

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_health(value):
	health = value
	print("health changed" + str(health))
	if health <= 0:
		emit_signal("no_health")
		print("no health")
