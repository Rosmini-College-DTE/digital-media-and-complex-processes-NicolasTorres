extends CharacterBody2D


var SPEED = 150.0
const JUMP_VELOCITY = -300.0

#the jump count
var jump_count = 0
var max_jumps = 2

var attacking = false

@onready var AS = $AnimatedSprite2D
@onready var AF : Area2D = $Direction/ActionableFinder
@onready var PM = $PauseMenu
@onready var HP = $Healthbar

var paused = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	if horizontal_direction:
		velocity.x = horizontal_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if horizontal_direction != 0:
			AS.flip_h = (horizontal_direction == -1)
	
	# Gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_floor():
		jump_count = 0
	
	# Jump + double jump
	if Input.is_action_just_pressed("jump") and jump_count < max_jumps:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
	
	if Input.is_action_just_pressed("pause"):
		pausemenu()
	

	update_animations(horizontal_direction)
	move_and_slide()

func pausemenu():
	if paused:
		PM.show()
		
		Engine.time_scale = 0
	else:
		PM.hide()
		
		Engine.time_scale = 1
		
	paused = !paused

#Dialogue
func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("dialoge_acc"):
		var actionables = AF.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			SPEED = 0
	elif DialogueManager.dialogue_ended:
		SPEED = 150.0
	
	
	if Input.is_action_just_pressed("hit"):
			AS.play("attack")





# Animation changing
func update_animations(horizontal_direction):
	if Input.is_action_pressed("hit"):
			attacking = true
	else:
		attacking = false
		
	if !attacking:
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
	else:
		AS.play("attack")
		
		



