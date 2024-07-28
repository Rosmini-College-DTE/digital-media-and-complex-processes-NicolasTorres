extends Control

@onready var SceneTransitionAnimation = $SceneTransitionAnimation/AnimationPlayer
@onready var scrollanimation = $AnimationPlayer

func _ready():
	SceneTransitionAnimation.play("fade_white_out")
	scrollanimation.play("scroll")
	$ColorRect.hide()
	await get_tree().create_timer(36.05).timeout
	$ColorRect.show()

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
