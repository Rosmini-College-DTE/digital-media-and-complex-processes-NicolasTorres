extends Control

@onready var openedcontrols = $Keybinds
@onready var backbutton = $backbutton
@onready var continuebutton = $menubuttons/Continue
@onready var controlbutton = $menubuttons/Controls
@onready var quitbutton = $menubuttons/Quit
@onready var pause_menu = $"."
@onready var volumes = $Volume


func _on_continue_pressed():
	$Accept.play()
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)
	if global.paused:
		pause_menu.show()
		Engine.time_scale = 0
	else:
		pause_menu.hide()
		Engine.time_scale = 1
		
	global.paused = !global.paused
	

func _on_controls_pressed():
	controlopener()
	$Accept.play()

func _on_quit_pressed():
	get_tree().quit()
	$Accept.play()

func _on_back_pressed():
	$Accept.play()
	openedcontrols.hide()
	backbutton.hide()
	continuebutton.show()
	controlbutton.show()
	quitbutton.show()
	volumes.show()

func controlopener():
	openedcontrols.show()
	backbutton.show()
	continuebutton.hide()
	controlbutton.hide()
	quitbutton.hide()
	volumes.hide()
	

func _on_continue_mouse_entered():
	$Select.play()

func _on_controls_mouse_entered():
	$Select.play()

func _on_quit_mouse_entered():
	$Select.play()

func _on_back_mouse_entered():
	$Select.play()
