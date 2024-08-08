extends Control

@onready var launch = $Launch/AnimationPlayer

func _ready():
	launch.play("startup")
	await get_tree().create_timer(17).timeout
	$Launch.hide()
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)

func _process(delta):
	global.bossDead = true
	state.obtained = false
	state.talk_status = "didnot"

func _on_start_pressed():
	$Accept.play()
	get_tree().change_scene_to_file("res://Scenes/StartGame.tscn")

func _on_controls_pressed():
	$Accept.play()
	var options = load("res://Scenes/controls.tscn").instantiate()
	get_tree().current_scene.add_child(options)

func _on_quit_pressed():
	get_tree().quit()



func _on_start_mouse_entered():
	$Select.play()

func _on_controls_mouse_entered():
	$Select.play()


func _on_quit_mouse_entered():
	$Select.play()
