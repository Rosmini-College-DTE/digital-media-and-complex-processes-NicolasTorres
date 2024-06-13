extends Control

@onready var openedcontrols = $Keybinds
@onready var backbutton = $backbutton
@onready var continuebutton = $menubuttons/Continue
@onready var controlbutton = $menubuttons/Controls
@onready var quitbutton = $menubuttons/Quit
@onready var PM = $"."



func _on_continue_pressed():
	if global.paused:
		PM.show()
		
		Engine.time_scale = 0
	else:
		PM.hide()
		
		Engine.time_scale = 1
		
	global.paused = !global.paused
	

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
	
