extends Control

@onready var SceneTransitionAnimation = $SceneTransitionAnimation/AnimationPlayer
@onready var scrollanimation = $AnimationPlayer
@onready var verseanim = $Label2/AnimationPlayer

func _ready():
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)
	SceneTransitionAnimation.play("fade_white_out")
	scrollanimation.play("scroll")
	verseanim.play("verse")
	$ColorRect.hide()
	await get_tree().create_timer(36.05).timeout
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
	$ColorRect.show()

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
