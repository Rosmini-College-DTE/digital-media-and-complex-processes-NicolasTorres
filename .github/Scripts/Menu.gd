extends Control

@onready var launch = $Launch/AnimationPlayer

func _ready():
	launch.play("startup")
	await get_tree().create_timer(17).timeout
	$Launch.hide()

func _process(delta):
	global.bossDead = true
	state.obtained = false
	state.talk_status = "didnot"

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/StartGame.tscn")

func _on_controls_pressed():
	var options = load("res://Scenes/controls.tscn").instantiate()
	get_tree().current_scene.add_child(options)

func _on_quit_pressed():
	get_tree().quit()

