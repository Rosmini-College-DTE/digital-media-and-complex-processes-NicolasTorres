extends Control

@onready var optionsmenu = $"."

func _on_back_pressed():
	$Accept.play()
	optionsmenu.hide()


func _on_back_mouse_entered():
	$Select.play()
