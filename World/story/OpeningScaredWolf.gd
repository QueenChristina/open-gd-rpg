extends TalkableItem

var count_mon_killed = 0

signal quest_finished(quest_title)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(_event):
	if interactable && Input.is_action_just_released("confirm") && talk_id != "0":
		UI.connect("dialog_ended", self, "_on_dialog_ended")
		if Globals.is_condition_met("data has_gotten_wolfy_slime_reward is true"):
			talk_id = "wolf_quest_post_finished"
		UI.start_dialog(talk_id)
		# to prevent you ending dialogue and immediately reentering...
		interactable = false
		# Set interactable again after end dialog!

func _on_slime_killed(mon_name):
	count_mon_killed += 1
	if count_mon_killed == 4:
		emit_signal("quest_finished", quest_title)
		talk_id = "wolf_quest_finished"
		quest_finished = true
