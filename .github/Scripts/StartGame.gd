extends Node2D


@onready var player_camera = $Player/Camera2D

#To change camera 'visibility' limit, make a limit using the help of a marker 2D

func _ready():
	player_camera.enabled = true
