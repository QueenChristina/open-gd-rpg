tool
extends PanelContainer


export(int) var file_no

onready var label = $HBoxContainer/VBoxContainer2/Label
onready var saver = $GameSaver

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = "Save file #" + str(file_no)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Save_pressed():
	saver.save(file_no)

func _on_Load_pressed():
	saver.load(file_no)
