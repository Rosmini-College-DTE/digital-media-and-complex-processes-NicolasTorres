extends Control

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
			var pause = load("res://Scenes/pausemenu.tscn").instantiate()
			get_tree().current_scene.add_child(pause)
			return
