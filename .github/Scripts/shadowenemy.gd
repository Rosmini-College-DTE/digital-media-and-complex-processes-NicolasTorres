extends CharacterBody2D

const speed = 30
var dir: Vector2

var is_shadow_chasing: bool

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var Player: CharacterBody2D

func ready():
	is_shadow_chasing = true

func _process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	move(delta)
	handle_animation()

func move(delta):
	if is_shadow_chasing:
		Player = global.playerBody
		velocity = dir * speed
	
	if !is_shadow_chasing:
		velocity += dir * speed * delta
		
	move_and_slide()

func _on_timer_timeout():
	$Timer.wait_time = choose([1.0,1.5,2.0])
	if !is_shadow_chasing:
		dir = choose([Vector2.RIGHT, Vector2.LEFT])
		print(dir)

func handle_animation():
	var animated_sprite = $animation
	animated_sprite.play("walking")
	if dir.x == -1:
		animated_sprite.flip_h = true
	elif dir.x == 1:
		animated_sprite.flip_h = false

func choose(array):
	array.shuffle()
	return array.front()
