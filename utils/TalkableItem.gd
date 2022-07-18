"""
Simple script to allow talkable objects when interacting in Interact area, 
with talk_id.
"""
extends StaticBody2D
class_name TalkableItem

export var talk_id = "0"
export(String) var quest_title = ""
export(String, MULTILINE) var quest_description = ""
var interactable = false
var is_in_interact_area = false
var quest_finished = false setget set_quest_finished

var SAVE_KEY = "TalkableItem_" + name # must be unique or will cause loading problems / weird bugs

# Called when the node enters the scene tree for the first time.
func _ready():
	SAVE_KEY = "TalkableItem_" + get_parent().get_parent().name + "_" + name
	
func set_quest_finished(value):
	quest_finished = value

func _input(_event):
	if interactable and Input.is_action_just_released("confirm") and talk_id != "0" and not GameState.is_paused():
		UI.connect("dialog_ended", self, "_on_dialog_ended")
		UI.start_dialog(talk_id)
		# to prevent you ending dialogue and immediately reentering...
		interactable = false
		# Set interactable again after end dialog!

func _on_Interact_body_shape_entered(_body_id, body, _body_shape, _area_shape):
	if body.is_in_group("Player"):
		interactable = true
		is_in_interact_area = true

func _on_Interact_body_shape_exited(_body_id, body, _body_shape, _area_shape):
	if body != null and body.is_in_group("Player"):
		interactable = false
		is_in_interact_area = false

func _on_dialog_ended(_text_id):
	UI.disconnect("dialog_ended", self, "_on_dialog_ended")
	# A slightly hacky way of allowing item to be interactable again w/o re-entering area
	# after dialog ends, but without accidentally triggering it on last click, 
	# setting to be interactable again only if player is still in area.
	if quest_title != "" and not quest_finished:
		UI.show_quest(quest_title, quest_description)
		yield(GameState, "unpaused")
	yield(get_tree().create_timer(0.5), "timeout")
	
	if is_in_interact_area:
		interactable = true
		
func save(save_game: Resource):
	save_game.data[SAVE_KEY] = {
		"quest_finished" : quest_finished,
		"talk_id" : talk_id
	}

func load(save_game: Resource):
	if save_game.data.has(SAVE_KEY):
		var data : Dictionary = save_game.data[SAVE_KEY]
		quest_finished = data["quest_finished"]
		talk_id = data["talk_id"]
