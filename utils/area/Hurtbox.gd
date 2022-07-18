extends Area2D

const hitEffect = preload("res://Assets/sfx/Sparkle.tscn")
var invincible = false
onready var timer = $Timer

func _ready():
	GameState.connect("paused", self, "on_game_paused")
	GameState.connect("unpaused", self, "on_game_unpaused")

func on_game_paused():
	timer.paused = true
	
func on_game_unpaused():
	timer.paused = false

func create_hit_effect():
	var effect = hitEffect.instance()
	get_parent().add_child(effect)
	effect.connect("animation_finished", self, "_on_effect_animation_finished", [effect])
	effect.frame = 0
	effect.playing = true
	
func _on_effect_animation_finished(effect):
	if effect != null and get_parent() != null:
		effect.queue_free()

func _on_Timer_timeout():
	self.invincible = !self.invincible
	monitorable = !monitorable # retrigger area_entered
