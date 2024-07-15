extends Node2D

@onready var SceneTransitionAnimation = $SceneTransitionAnimation/AnimationPlayer
@onready var player_camera = $Player/Camera2D

func _ready():
	global.bossDead = false
	state.agreed = false
	SceneTransitionAnimation.play("fade_out")
	await get_tree().create_timer(1).timeout
	$SceneTransitionAnimation.hide()
	player_camera.enabled = true

func _process(delta):
	if state.obtained == true:
		$SceneTransitionAnimation.show()
		SceneTransitionAnimation.play("fade_white_in")
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://Scenes/Depths/end_game.tscn")
