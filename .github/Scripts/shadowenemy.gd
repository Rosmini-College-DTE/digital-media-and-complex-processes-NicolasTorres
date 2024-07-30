extends CharacterBody2D

class_name ShadowEnemy

@onready var deal_damage_zone = $ShadowDealDamageArea

var speed = 40
var is_shadow_chase: bool

var health = 60
var health_max = 60
var health_min = 0

var dead: bool = false
var taking_damage: bool = false
var damage_to_deal = 10
var is_dealing_damage: bool

var dir: Vector2
const gravity = 900
var knockback_force = -40

var is_roaming: bool

var player: CharacterBody2D
var player_in_area = false

func _ready():
	is_shadow_chase = false

func _process(delta):
	global.shadowDamageAmount = damage_to_deal
	global.shadowDamageZone = $ShadowDealDamageArea
	
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
		elif is_shadow_chase and !taking_damage and global.playerAlive:
			speed = 80
			var dir_to_player = position.direction_to(player.position) * speed
			velocity.x = dir_to_player.x
			dir.x = abs(velocity.x) / velocity.x
		elif taking_damage:
			var knockback_dir = position.direction_to(player.position) * knockback_force
			velocity.x = knockback_dir.x
		is_roaming = true
	elif dead:
		velocity.x = 0

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
		await get_tree().create_timer(.25).timeout
		taking_damage = false
	elif dead and is_roaming:
		var damage_zone_collision = deal_damage_zone.get_node("CollisionShape2D")
		is_roaming = false
		anim_sprite.play("death")
		damage_zone_collision.disabled = true
		await get_tree().create_timer(1.1).timeout
		anim_sprite.play("smoke")
		await get_tree().create_timer(.667).timeout
		handle_death()
	elif !dead and is_dealing_damage:
		anim_sprite.play("deal_damage")

func _on_shadow_deal_damage_area_area_entered(area):
	if area == global.playerHitbox:
		is_dealing_damage = true
		await get_tree().create_timer(.556).timeout
		is_dealing_damage = false

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

func _on_detection_area_area_entered(area):
	if area == global.playerDetectionHitbox:
		if global.playerAlive:
			is_shadow_chase = true
		elif !global.playerAlive:
			is_shadow_chase = false
func _on_detection_area_area_exited(area):
	if area == global.playerDetectionHitbox:
		is_shadow_chase = false

func _on_hitbox_area_entered(area):
	var damage = global.playerDamageAmount
	if area == global.playerDamageZone:
		take_damage(damage)
func take_damage(damage):
	health -= damage
	taking_damage = true
	if health <= health_min:
		health = health_min
		dead = true
