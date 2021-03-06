extends MarginContainer


onready var item_grid_container = $TabContainer/Items/HBoxContainer/MarginContainer/GridContainer
onready var item_name = $TabContainer/Items/HBoxContainer/MarginContainer2/VBoxContainer/Label
onready var item_description = $TabContainer/Items/HBoxContainer/MarginContainer2/VBoxContainer/RichTextLabel
onready var use_item_button = $TabContainer/Items/HBoxContainer/MarginContainer2/VBoxContainer/UseButton
var curr_selected_item_container = null
# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerStats.connect("inventory_changed", self, "on_inventory_changed")
	for item_container in item_grid_container.get_children():
		item_container.connect("pressed", self, "on_item_container_selected", [item_container])
		
func on_inventory_changed():
	# Erase the inventory
	for item_container in item_grid_container.get_children():
		item_container.icon = null
		item_container.item_name = ""
		item_container.item_description = ""
		item_container.add_hp = 0
		item_container.amount = 0
		item_name.text = ""
		item_description.text = ""
	
	var item_index = 0
	# Populate the inventory
	for item in PlayerStats.inventory.keys():
		var item_data = Globals.db_items[item]
		var item_container = item_grid_container.get_children()[item_index]
		item_container.item_key = item
		item_container.icon = load(item_data["icon"])
		item_container.item_name = item_data["name"] # item is the key value used in editor, may differ from name
		item_container.item_description = item_data["description"]
		item_container.add_hp = item_data["add_hp"]
		item_container.amount = PlayerStats.inventory[item]
		item_index += 1
		item_container.connect("pressed", self, "on_item_container_selected", [item_container]) # testing
		
func on_item_container_selected(item_container):
	print("selected item " + item_container.item_name)
	curr_selected_item_container = item_container
	item_name.text = item_container.item_name
	item_description.text = item_container.item_description
	use_item_button.connect("pressed", self, "on_item_used", [item_container])
	if item_container.add_hp != 0:
		use_item_button.disabled = false
	else:
		use_item_button.disabled = true

func on_item_used(item_container):
	PlayerStats.health += item_container.add_hp
	PlayerStats.remove_inventory_item(item_container.item_key, 1)
	on_inventory_changed()
	if item_container.add_hp != 0:
		use_item_button.disabled = false
	else:
		use_item_button.disabled = true

func _on_Menu_visibility_changed():
	if self.visible:
		GameState.menu_opened = true
	else:
		GameState.menu_opened = false
