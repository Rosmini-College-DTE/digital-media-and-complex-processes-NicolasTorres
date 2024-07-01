extends CharacterBody2D

class_name Heals

@onready var heal_zone = $"."


func _ready():
	global.healZone = heal_zone 

func _on_area_2d_area_entered(area):
	await get_tree().create_timer(1).timeout
	self.queue_free()
