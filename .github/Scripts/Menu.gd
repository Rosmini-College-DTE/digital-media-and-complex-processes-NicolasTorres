extends Control

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/StartGame.tscn")

func _on_controls_pressed():
	var options = load("res://Scenes/controls.tscn").instantiate()
	get_tree().current_scene.add_child(options)

func _on_quit_pressed():
	get_tree().quit()
