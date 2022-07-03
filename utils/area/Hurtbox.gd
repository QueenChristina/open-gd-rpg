extends Area2D

const hitEffect = preload("res://Assets/sfx/Sparkle.tscn")
var effect = null

var invincible = false

func create_hit_effect():
	effect = hitEffect.instance()
	get_parent().add_child(effect)
	effect.connect("animation_finished", self, "_on_effect_animation_finished")
	effect.frame = 0
	effect.playing = true
	
func _on_effect_animation_finished():
	if effect != null:
		effect.queue_free()

func _on_Timer_timeout():
	self.invincible = !self.invincible
	monitorable = !monitorable # retrigger area_entered
