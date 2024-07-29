extends Node2D

@onready var SceneTransitionAnimation = $SceneTransitionAnimation/AnimationPlayer
@onready var player_camera = $Player/Camera2D
@onready var fire = $AnimationPlayer
#To change camera 'visibility' limit, make a limit using the help of a marker 2D

func _ready():
	SceneTransitionAnimation.play("fade_out")
	fire.play("light")
	await get_tree().create_timer(1).timeout
	$SceneTransitionAnimation.hide()
	player_camera.enabled = true
	

func _process(delta):
	if state.agreed:
		$SceneTransitionAnimation.show()
		SceneTransitionAnimation.play("fade_in")
