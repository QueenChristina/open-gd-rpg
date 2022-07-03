extends CanvasLayer

signal dialog_ended(text_id)

onready var control = $Control
onready var dialog = $DialogSmall
onready var dialog_black = $DialogBlack
onready var health_bar = $Control/Health
onready var exp_bar = $Control/ExpBar
onready var money_label = $Control/Money
onready var quest_panel = $QuestPanel
# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerStats.connect("health_changed", self, "set_health_bar")
	PlayerStats.connect("exp_changed", self, "set_exp_bar")
	PlayerStats.connect("money_changed", self, "set_money")

func start_dialog(index, dialog_style = ""):
	# Choose different dialog box styles
	if dialog_style == "black":
		dialog_black.start_dialog(index)
	else:
		# Default style
		dialog.start_dialog(index)
	print("Started dialog of index " + index)
	# TODO: change text_box layout (center-top vs center-bottom) based on speaker position.
	
	# NOTE: make sure the position of dialog does NOT change during game, 
	# otherwise it can mess up position of Next icon. -- be sure to set layout!

func _on_dialog_ended(text_id):
	emit_signal("dialog_ended", text_id)

func set_health_bar():
	health_bar.value = PlayerStats.get_health()
	health_bar.max_value = PlayerStats.max_health
	print("set health bar to" + str(health_bar.value) + " of " + str(health_bar.max_value))
	
func set_exp_bar():
	exp_bar.value = PlayerStats.experience
	exp_bar.max_value = PlayerStats.max_experience
	print("set exp bar to " + str(exp_bar.value) + " of " + str(exp_bar.max_value))
	
func set_money():
	money_label.text = str(PlayerStats.money)
	
func hide():
	control.hide()
	
func show():
	control.show()

func show_quest(title, description):
	quest_panel.show()
	GameState.cutscene = true
	quest_panel.title = title
	quest_panel.description = description
