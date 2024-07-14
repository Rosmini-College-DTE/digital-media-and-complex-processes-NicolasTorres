extends Node2D

@onready var SceneTransitionAnimation = $SceneTransitionAnimation/AnimationPlayer
@onready var player_camera = $Player/Camera2D

func _ready():
	state.agreed = false
	SceneTransitionAnimation.play("fade_out")
	player_camera.enabled = true

func _process(delta):
	if state.obtained == true:
		SceneTransitionAnimation.play("fade_white_in")
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://Scenes/Depths/end_game.tscn")
