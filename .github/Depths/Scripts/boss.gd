extends CharacterBody2D

class_name Boss

@onready var deal_damage_zone = $BossDealDamageArea
@onready var deal_heavy_damage_zone = $BossDealHeavyDamageArea
@onready var deal_light_damage_zone = $BossDealLightDamageArea

var attack_type: int

var speed = 50
var is_boss_chase: bool

var health = 1200
var health_max = 1200
var health_min = 0

var dead: bool = false
var taking_damage: bool = false
var damage_to_deal = 20
var light_damage = 30
var heavy_damage = 40
var is_dealing_damage: bool
var is_dealing_heavy_damage: bool
var is_dealing_light_damage: bool

var dir: Vector2
const gravity = 600
var knockback_force = -50

var is_roaming: bool

var player: CharacterBody2D
var player_in_area = false

func _ready():
	is_boss_chase = false
	health = 1200


func _process(delta):
	global.bossDamageZone = $BossDealDamageArea
	global.bossDead = dead
	
	if !is_on_floor():
		velocity.y += gravity * delta
		velocity.x = 0
	
	player = global.playerBody
	
	move(delta)
	move_and_slide()
	handle_animation()

func move(delta):
	if !dead:
		if !is_boss_chase:
			velocity += dir * speed * delta
		elif is_boss_chase and !taking_damage and global.playerAlive:
			speed = 50
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
	var damage_zone_collision = deal_damage_zone.get_node("CollisionShape2D")
	var damage_heavy_zone_collision = deal_heavy_damage_zone.get_node("CollisionShape2D")
	var damage_light_zone_collision = deal_light_damage_zone.get_node("CollisionShape2D")
	if !dead and !taking_damage and !is_dealing_damage:
		anim_sprite.play("walking")
		if dir.x == -1:
			anim_sprite.flip_h = true
			deal_heavy_damage_zone.position.x = -173
			deal_light_damage_zone.position.x = -62
		elif dir.x == 1:
			anim_sprite.flip_h = false
			deal_heavy_damage_zone.position.x = 1
			deal_light_damage_zone.position.x = 1
	elif !dead and taking_damage and !is_dealing_damage:
		anim_sprite.play("hurt")
		await get_tree().create_timer(.600).timeout
		taking_damage = false
	elif dead and is_roaming:
		is_roaming = false
		
		anim_sprite.play("death")
		damage_zone_collision.disabled = true
		damage_heavy_zone_collision.disabled = true
		damage_light_zone_collision.disabled = true
		await get_tree().create_timer(1.25).timeout
		anim_sprite.play("smoke")
		await get_tree().create_timer(.7).timeout
		handle_death()
	elif !dead and is_dealing_damage:
		if !dead and is_dealing_heavy_damage:
			anim_sprite.play("deal_damage2")
		if !dead and is_dealing_light_damage:
			anim_sprite.play("deal_damage")


func _on_boss_deal_damage_area_area_entered(area):
	if area == global.playerHitbox:
		global.bossDamageAmount = damage_to_deal
		is_dealing_damage = true
		await get_tree().create_timer(.65).timeout
		is_dealing_damage = false

func _on_boss_deal_heavy_damage_area_area_entered(area):
	if area == global.playerHitbox:
		global.bossDamageAmount = heavy_damage
		is_dealing_damage = true
		is_dealing_heavy_damage = true
		await get_tree().create_timer(.643).timeout
		is_dealing_heavy_damage = false
		is_dealing_damage = false
		cooldown_heavy()

func cooldown_heavy():
	var damage_zone_collision = deal_damage_zone.get_node("CollisionShape2D")
	var damage_heavy_zone_collision = deal_heavy_damage_zone.get_node("CollisionShape2D")
	var damage_light_zone_collision = deal_light_damage_zone.get_node("CollisionShape2D")
	damage_heavy_zone_collision.disabled = true
	await get_tree().create_timer(10).timeout
	damage_heavy_zone_collision.disabled = false

func _on_boss_deal_light_damage_area_area_entered(area):
	if area == global.playerHitbox:

		global.bossDamageAmount = light_damage
		is_dealing_light_damage = true
		is_dealing_damage = true
		await get_tree().create_timer(.584).timeout
		is_dealing_light_damage = false
		is_dealing_damage = false
		cooldown_light()

func cooldown_light():
	var damage_zone_collision = deal_damage_zone.get_node("CollisionShape2D")
	var damage_heavy_zone_collision = deal_heavy_damage_zone.get_node("CollisionShape2D")
	var damage_light_zone_collision = deal_light_damage_zone.get_node("CollisionShape2D")
	damage_light_zone_collision.disabled = true
	await get_tree().create_timer(3).timeout
	damage_light_zone_collision.disabled = false

func handle_death():
	dead = true
	self.queue_free()

func _on_timer_timeout():
	$DirectionTimer.wait_time = choose([0,0,0])
	if !is_boss_chase:
		dir = choose([Vector2.RIGHT, Vector2.LEFT])
		velocity.x = 0

func choose(array):
	array.shuffle()
	return array.front()

func _on_detection_area_area_entered(area):
	if area == global.playerDetectionHitbox:
		if global.playerAlive:
			is_boss_chase = true
		elif !global.playerAlive:
			is_boss_chase = false
func _on_detection_area_area_exited(area):
	if area == global.playerDetectionHitbox:
		is_boss_chase = false

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
