extends PanelContainer

export(String) var title = "" setget set_title
export(String) var description = "" setget set_description

onready var label_title = $VBoxContainer/Label
onready var label_desc = $VBoxContainer/RichTextLabel

# TODO: add to quest log with quest id and count monsters/track progress with quest rewards
# TODO: use GameSrc's Globals.data to track quest progress eg. Globals.data[quest_id_prgss] += 1 (# of slimes killed)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_title(value):
	title = value
	label_title.text = title

func set_description(value):
	description = value
	label_desc.text = description

func _on_Button_pressed():
	GameState.cutscene = false
	self.hide()
