extends Node2D

@onready var SceneTransitionAnimaiton = $SceneTransitionAnimation/AnimationPlayer
@onready var player_camera = $Player/Camera2D

#To change camera 'visibility' limit, make a limit using the help of a marker 2D

func _ready():
	SceneTransitionAnimaiton.play("fade_out")
	player_camera.enabled = true
	if state.agreed:
		await get_tree().create_timer(1).timeout
		SceneTransitionAnimaiton.play("fade_in")
