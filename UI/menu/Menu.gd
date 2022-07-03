extends MarginContainer


onready var item_grid_container = $TabContainer/Items/HBoxContainer/MarginContainer/GridContainer
onready var item_name = $TabContainer/Items/HBoxContainer/MarginContainer2/VBoxContainer/Label
onready var item_description = $TabContainer/Items/HBoxContainer/MarginContainer2/VBoxContainer/RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerStats.connect("inventory_changed", self, "on_inventory_changed")

func on_inventory_changed():
	var item_index = 0
	# Erase the inventory
	for item_container in item_grid_container.get_children():
		item_container.icon = null
		item_container.item_name = ""
		item_container.item_description = ""
		
		item_container.connect("pressed", self, "on_item_container_selected", [item_container])
	
	# Populate the inventory
	for item in PlayerStats.inventory.keys():
		var item_data = Globals.db_items[item]
		var item_container = item_grid_container.get_children()[item_index]
		item_container.icon = load(item_data["icon"])
		item_container.item_name = item
		item_container.item_description = item_data["description"]
		item_index += 1
		
func on_item_container_selected(item_container):
	item_name.text = item_container.item_name
	item_description.text = item_container.item_description
