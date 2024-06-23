extends Node2D

@onready var SceneTransitionAnimaiton = $SceneTransitionAnimation/AnimationPlayer
@onready var player_camera = $Player/Camera2D

func _ready():
	state.agreed = false
	SceneTransitionAnimaiton.play("fade_out")
	player_camera.enabled = true
