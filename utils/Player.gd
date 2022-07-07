extends KinematicBody2D

const MAX_SPEED = 150
var velocity = Vector2.ZERO

# Based on HeartBeasts' Action RPG
# https://www.youtube.com/watch?v=mAbG8Oi-SvQ&list=PL9FzW-m48fn2SlrW0KoLT4n5egNdX-W9a

# Different states
enum{MOVE, 
	ATTACK,
	INTERACT
}

var state = MOVE

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var sprite = $Sprite
onready var animationState = animationTree.get("parameters/playback")
onready var stats = PlayerStats # Instead of $PlayStats, as autoloaded gets put at root of tree - modify the one at the root
onready var hitbox = $HitboxPivot/Hitbox
onready var hitboxPivot = $HitboxPivot
onready var hurtbox = $Hurtbox
onready var swordPivot = $SwordPivot
onready var hurtSound = $hurtSound
onready var lvSound = $lvSound
onready var lvUpEffect = $LvUp
onready var SAVE_KEY: String = "player"
var knockback = Vector2.ZERO

func _ready():
	add_to_group("Player")
	animationTree.active = true
	hitbox.knockback_vector = Vector2.LEFT
	PlayerStats.connect("lv_changed", self, "on_lv_up")
	
func on_lv_up():
	lvUpEffect.frame = 0
	lvSound.play()
	lvUpEffect.play("default")

func _physics_process(delta):
	PlayerStats.player_position = global_position
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state(delta)
		
func move_state(delta):
	var input_vector = Vector2.ZERO
	# Get action strength is 0 to 1 for joypad; 1 for keyboard if pressed
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	# detect if attack 
	if Input.is_action_just_pressed("attack") and !GameState.is_paused():
		state = ATTACK
	# Run only if game not paused.
	elif input_vector != Vector2.ZERO and !GameState.is_paused():
		# do knockback
		hitbox.knockback_vector = input_vector
		# Set idle here so it will 'remember' the last direction
		# based on coordinate grid triangle in tree.
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		sprite.flip_h = input_vector.x < 0
		if input_vector.x < 0:
			swordPivot.scale.x = -1
			hitboxPivot.scale.x = -1
		else:
			swordPivot.scale.x = 1
			hitboxPivot.scale.x = 1
		animationState.travel("Run")
		# Multiply velocity by delta incase of computer lag
		velocity = MAX_SPEED * input_vector * delta
	else:
		# Not moving
		animationState.travel("Idle")
		velocity = Vector2.ZERO
	
	# get knocked back
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)
	move_and_collide(velocity + delta * knockback)
	
func attack_state(_delta):
	velocity = Vector2.ZERO #to stop sliding
	animationState.travel("Attack")
	
# with separate function, end attack by change state
func attack_state_finished():
	state = MOVE

func save(save_game: Resource):
	save_game.data[SAVE_KEY] = {
		'experience': stats.experience,
		'health': stats.health,
		'inventory': stats.inventory,
		'global position' : self.global_position
	}

func load(save_game: Resource):
	var data: Dictionary = save_game.data[SAVE_KEY]
	stats.experience = data['experience']
	stats.health = data['health']
	stats.inventory = data['inventory']
	self.global_position = data['global position']


# When an enemy hitbox enters the player's hurtbox
func _on_Hurtbox_area_entered(area):
	if area.damage > 0:
		stats.health -= area.damage
		hurtbox.create_hit_effect()
		hurtSound.play()
		if area.knockback_vector != Vector2.ZERO:
			print("knocked back!!!!")
			knockback = area.knockback_vector * area.knockback_factor

func _on_Stats_no_health():
#	self.queue_free()
	print("GAME OVER - player dead")


func _on_LvUp_animation_finished():
	lvUpEffect.frame = 6
