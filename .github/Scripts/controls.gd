extends Control


func _on_back_pressed():
	var menus = load("res://Scenes/Menu.tscn").instantiate()
	get_tree().current_scene.add_child(menus)
	
