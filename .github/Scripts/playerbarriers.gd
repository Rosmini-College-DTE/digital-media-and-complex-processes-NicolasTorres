extends StaticBody2D

var boss_Dead: bool

func _ready():
	boss_Dead = global.bossDead

func _process(delta):
	if global.bossDead:
		self.hide()
		await get_tree().create_timer(.2).timeout
		self.queue_free()
	elif !global.bossDead:
		pass

