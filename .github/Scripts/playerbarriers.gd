extends StaticBody2D

func _ready():
	if !global.bossAlive:
		self.queue_free()
