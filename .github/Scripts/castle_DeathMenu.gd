extends Control


func _ready():
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
 
func _on_quit_pressed():
	get_tree().quit()

func _on_restart_pressed():
	get_tree().change_scene_to_file("res://Scenes/StartGame.tscn")
