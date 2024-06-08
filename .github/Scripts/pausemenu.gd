extends Control

@onready var openedcontrols = $Keybinds
@onready var backbutton = $backbutton
@onready var continuebutton = $menubuttons/Continue
@onready var controlbutton = $menubuttons/Controls
@onready var quitbutton = $menubuttons/Quit
@onready var PM = $"."

var paused = false


func _on_continue_pressed():
	PM.hide()
	paused = true
	Engine.time_scale = 1

func _on_controls_pressed():
	controlopener()

func _on_quit_pressed():
	get_tree().quit()

func _on_back_pressed():
	openedcontrols.hide()
	backbutton.hide()
	continuebutton.show()
	controlbutton.show()
	quitbutton.show()

func controlopener():
	openedcontrols.show()
	backbutton.show()
	continuebutton.hide()
	controlbutton.hide()
	quitbutton.hide()
	



