extends CharacterBody2D

class_name ShadowEnemy

var speed = 20
var is_shadow_chase: bool = true

var health = 100
var health_max = 100
var health_min = 0

var dead: bool = false
var taking_damage: bool = false
var damage_dealing = 20
var is_dealing_damage: bool = false

var dir: Vector2
const gravity = 900
var knockback_force = 200

var is_roaming: bool = true

var player: CharacterBody2D
var player_in_area = false

#func _ready():
	#is_shadow_chase = false

func _process(delta):
	if !is_on_floor():
		velocity.y += gravity * delta
		velocity.x = 0
	
	player = global.playerBody
	
	move(delta)
	move_and_slide()
	handle_animation()

func move(delta):
	if !dead:
		if !is_shadow_chase:
			velocity += dir * speed * delta
		elif is_shadow_chase and !taking_damage:
			speed = 40
			var dir_to_player = position.direction_to(player.position) * speed
			velocity.x = dir_to_player.x
			dir.x = abs(velocity.x) / velocity.x
		is_roaming = true
	elif dead:
		velocity.x = 0
#		if is_shadow_chase:
#			player = global.playerBody
#			velocity = position.direction_to(player.position) * speed

func handle_animation():
	var anim_sprite = $animation
	if !dead and !taking_damage and !is_dealing_damage:
		anim_sprite.play("walking")
		if dir.x == -1:
			anim_sprite.flip_h = true
		elif dir.x == 1:
			anim_sprite.flip_h = false
	elif !dead and taking_damage and !is_dealing_damage:
		anim_sprite.play("hurt")
		await get_tree().create_timer(.715).timeout
		taking_damage = false
	elif dead and is_roaming:
		is_roaming = false
		anim_sprite.play("death")
		await get_tree().create_timer(1.0).timeout
		handle_death()

func handle_death():
	self.queue_free()

func _on_timer_timeout():
	$DirectionTimer.wait_time = choose([1.5,2.0,2.5])
	if !is_shadow_chase:
		dir = choose([Vector2.RIGHT, Vector2.LEFT])
		velocity.x = 0


func choose(array):
	array.shuffle()
	return array.front()
