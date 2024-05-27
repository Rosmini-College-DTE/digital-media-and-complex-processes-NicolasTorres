extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0

#the jump count
var jump_count = 0
var max_jumps = 2

#Sprite animation
@onready var AS = $AnimatedSprite2D
@onready var AF : Area2D = $Direction/ActionableFinder

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if is_on_floor():
		jump_count = 0
	
	# Change from idle to running animation
	
	# Jump + double jump
	if Input.is_action_just_pressed("jump") and jump_count < max_jumps:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
		
	# Change into jumping animation
	
	# Keybinds
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	if horizontal_direction:
		velocity.x = horizontal_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	
	# Flipping directions
	if horizontal_direction != 0:
		AS.flip_h = (horizontal_direction == -1)
		
	move_and_slide()
	
	update_animations(horizontal_direction)

#Dialogue
func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("dialoge_acc"):
		var actionables = AF.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			return

# Animation changing
func update_animations(horizontal_direction):
	if is_on_floor():
		if horizontal_direction == 0:
			AS.play("idle")
		else:
			AS.play("run")
	else:
		if velocity.y < 0:
			AS.play("jumping")
		elif velocity.y > 0:
			AS.play("falling")


