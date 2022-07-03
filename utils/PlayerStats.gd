extends Node

# Player stats eg. health, inventory, skills, etc
# https://github.com/GDQuest/godot-make-pro-2d-games/tree/master/actors/player

export(int) var max_health = 50 setget set_max_health
onready var health = max_health setget set_health, get_health
var experience = 0 setget set_exp # cycles to 0 with level upgrades
var max_experience = 100 setget set_max_exp
var level = 1
var inventory = {} # item : amount, item must match item in db_items
var money = 0 setget set_money

signal no_health
signal health_changed
signal inventory_changed
signal exp_changed
signal money_changed

func set_money(value):
	money = value
	emit_signal("money_changed")

func set_max_health(value):
	max_health = clamp(value, 0, value)
	emit_signal("health_changed")

func set_health(value):
	health = clamp(value, 0, max_health)
	emit_signal("health_changed")
	print("Health at "+ str(health) + str(max_health))
	if health <= 0:
		emit_signal("no_health")

func get_health():
	return health

func set_exp(value):
	experience = value
	emit_signal("exp_changed")
	
func set_max_exp(value):
	max_experience = value
	emit_signal("exp_changed")

# Adds single item to inventory.
# Amount must be >= 0
func add_inventory_item(item, amount):
	if inventory.has(item):
		inventory[item] += amount
	else:
		if amount > 0:
			inventory[item] = amount
	print("Current player inventory: " + str(inventory))
	emit_signal("inventory_changed")
	
# Removes item from inventory of amount.
# Amount must be >= 0.
# Returns whether removal was successful.
func remove_inventory_item(item, amount):
	# Attempt to remove one item.
	if inventory.has(item) and inventory[item] >= amount:
		inventory[item] -= amount
		if inventory[item] == 0:
			# Remove item key:value pair if zero items.
			inventory.erase(item)
		print("Current player inventory: " + str(inventory))
		emit_signal("inventory_changed")
		return true
	# Not enough of item to remove.
	print("Current player inventory: " + str(inventory))
	return false
