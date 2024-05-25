extends Sprite2D


func _process(delta):
	global_position += (get_global_mouse_position()/1.5*delta)-global_position
