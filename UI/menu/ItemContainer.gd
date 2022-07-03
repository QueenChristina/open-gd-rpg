extends Button

export(String) var item_name = ""
export(String) var item_description = ""
export(int) var add_hp = 0
export(int) var amount = 0 setget set_amount

onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func set_amount(value):
	amount = value
	if amount == 0 or amount == 1:
		label.visible = false
	else:
		label.visible = true
		label.text = str(amount) + " "
