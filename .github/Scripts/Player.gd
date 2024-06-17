extends CharacterBody2D

@onready var anim_sprite = $AnimatedSprite2D
@onready var dialogue_detector : Area2D = $Direction/ActionableFinder
@onready var pause_menu = $PauseMenu
@onready var deal_damage_zone = $DealDamageZone
#@onready var HP = $Healthbar

var weapon_equip: bool

var speed = 150.0

const jump_power = -300.0
var jump_count = 0
var max_jumps = 2

var attack_type: String
var current_attack: bool

var gravity = 900

var health = 100
var health_max = 100
var health_min = 0
var can_take_damage: bool
var dead: bool


func _ready():
	global.playerBody = self
	current_attack = false
	dead = false
	can_take_damage = true
	global.playerAlive = true

func _physics_process(delta):
	weapon_equip = global.playerWeaponEquip
	global.playerDamageZone = deal_damage_zone
	
	if not is_on_floor():
		velocity.y += gravity * delta
	if is_on_floor():
		jump_count = 0
	if !dead:
		if Input.is_action_just_pressed("jump") and jump_count < max_jumps:
			velocity.y = jump_power
			jump_count += 1
		var direction = Input.get_axis("left", "right")
		if direction:
				velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
	
		if Input.is_action_just_pressed("pause"):
			pausemenu()
	
		if weapon_equip and !current_attack:
			if Input.is_action_just_pressed("left_mouse") or Input.is_action_just_pressed("right_mouse"):
				current_attack = true
				if Input.is_action_just_pressed("left_mouse") and is_on_floor():
					attack_type = "single"
				elif Input.is_action_just_pressed("right_mouse") and is_on_floor():
					attack_type = "double"
				elif Input.is_action_just_pressed("right_mouse") and !is_on_floor():
					attack_type = "double"
				else:
					attack_type = "air"
				set_damage(attack_type)
				handle_attack_animation(attack_type)
		handle_movement_animation(direction)
		check_hitbox()
	move_and_slide()

func check_hitbox():
	var hitbox_areas = $PlayerHitbox.get_overlapping_areas()
	var damage: int
	if hitbox_areas:
		var hitbox = hitbox_areas.front()
		if hitbox.get_parent() is ShadowEnemy:
			damage = global.shadowDamageAmount
		#add more as more entities are added
	if can_take_damage:
		take_damage(damage)

func take_damage(damage):
	if damage != 0:
		if health > 0:
			health -= damage
			print("player health: ", health)
			if health <= 0:
				health = 0
				dead = true
				global.playerAlive = false
				handle_death_animation()
			take_damage_cooldown(1.0)

func handle_death_animation():
	velocity.x = 0
	$PlayerHitbox/CollisionShape2D.position.y = 5
	anim_sprite.play("death")
	await get_tree().create_timer(0.5).timeout
	$Camera2D.zoom.x = 4
	$Camera2D.zoom.y = 4
	await get_tree().create_timer(3.5).timeout
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
	self.queue_free()
	

func take_damage_cooldown(wait_time):
	can_take_damage = false
	await get_tree().create_timer(wait_time).timeout
	can_take_damage = true

func handle_movement_animation(dir):
	if !weapon_equip:
		if is_on_floor():
			if !velocity.x:
				anim_sprite.play("idle")
			if velocity.x:
				anim_sprite.play("run")
				toggle_flip_sprite(dir)
		elif !is_on_floor():
			if velocity.y > 0:
				anim_sprite.play("jump")
			elif velocity.y < 0:
				anim_sprite.play("fall")
	elif weapon_equip:
		if is_on_floor() and !current_attack:
			if !velocity.x:
				anim_sprite.play("weapon_idle")
			if velocity.x:
				anim_sprite.play("weapon_run")
				toggle_flip_sprite(dir)
		elif !is_on_floor() and !current_attack:
			if velocity.y > 0:
				anim_sprite.play("weapon_jump")
				toggle_flip_sprite(dir)
			elif velocity.y < 0:
				anim_sprite.play("weapon_fall")
				toggle_flip_sprite(dir)

func toggle_flip_sprite(dir):
	if dir == 1:
		anim_sprite.flip_h = false
		deal_damage_zone.scale.x = 1
	if dir == -1:
		anim_sprite.flip_h = true
		deal_damage_zone.scale.x = -1

func handle_attack_animation(attack_type):
	if weapon_equip:
		if current_attack:
			var attack_anim = str(attack_type, "_attack")
			anim_sprite.play(attack_anim)
			toggle_damage_collisions(attack_type)

func toggle_damage_collisions(attack_type):
	var damage_zone_collision = deal_damage_zone.get_node("CollisionShape2D")
	var wait_time: float
	if attack_type == "air":
		wait_time = 0.7
	elif attack_type == "single":
		wait_time = 0.375
	elif attack_type == "double":
		wait_time = 0.5
	damage_zone_collision.disabled = false
	await get_tree().create_timer(wait_time).timeout
	damage_zone_collision.disabled = true

#Pause Menu
func pausemenu():
	if global.paused:
		pause_menu.show()
		Engine.time_scale = 0
	else:
		pause_menu.hide()
		Engine.time_scale = 1
	global.paused = !global.paused

#Dialogue
func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		var actionables = dialogue_detector.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			speed = 0
	elif DialogueManager.dialogue_ended:
		speed = 150.0


func _on_animated_sprite_2d_animation_finished():
	current_attack = false

func set_damage(attack_type):
	var current_damage_to_deal: int
	if attack_type == "single":
		current_damage_to_deal = 10
	elif attack_type == "double":
		current_damage_to_deal = 20
	elif attack_type == "air":
		current_damage_to_deal = 30
	global.playerDamageAmount = current_damage_to_deal
