extends Area2D

# Unlike pickable item, you don't need dialog to pick this loot up. Simply step over it.
export(String) var item = "money" # key of item, should match data/Item.Json, or special "money"
export(String) var item_name = "money" # name to be displayed in game, might not match item key
export(int) var amount = 1

onready var sprite = $Sprite

func set_icon(icon):
	sprite.texture = icon

# When player enters loot area....
func _on_Loot_body_entered(body):
	if body.is_in_group("Player"):
		if item != "money":
			PlayerStats.add_inventory_item(item, amount)
		else:
			PlayerStats.money += amount
		self.queue_free()

