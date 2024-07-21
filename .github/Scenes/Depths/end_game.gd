extends Control

@onready var SceneTransitionAnimation = $SceneTransitionAnimation/AnimationPlayer

func _ready():
	SceneTransitionAnimation.play("fade_white_out")
	$Button.hide()
	await get_tree().create_timer(2).timeout
	$Button.show()

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
