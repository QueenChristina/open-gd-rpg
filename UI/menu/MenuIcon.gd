extends TextureButton

export(NodePath) onready var menu_path
var menu

# Called when the node enters the scene tree for the first time.
func _ready():
	menu = get_node(menu_path)

func _on_MenuIcon_pressed():
	print('asdf')
	menu.visible = !menu.visible
