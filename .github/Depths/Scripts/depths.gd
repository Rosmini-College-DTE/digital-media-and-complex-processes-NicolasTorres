extends Node2D

@onready var SceneTransitionAnimation = $SceneTransitionAnimation/AnimationPlayer
@onready var player_camera = $Player/Camera2D
@onready var Labelanim = $Player/label_anim

func _ready():
	global.bossDead = false
	state.agreed = false
	SceneTransitionAnimation.play("fade_out")
	await get_tree().create_timer(1).timeout
	$SceneTransitionAnimation.hide()
	player_camera.enabled = true

func _process(delta):
	if global.bossDead == true:
		$Lights/PointLight2D13.hide()
		$Light/PointLight2D.show()
		Labelanim.play("Fadeout")
		await get_tree().create_timer(5).timeout
		$Player/Label.hide()
	
	if state.obtained == true:
		$Light/PointLight2D.hide()
		$SceneTransitionAnimation.show()
		SceneTransitionAnimation.play("fade_white_in")
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://Scenes/Depths/end_game.tscn")
