extends CharacterBody2D

class_name Heals

@onready var heal_zone = $"."


func _ready():
	global.healZone = heal_zone 

func _on_area_2d_area_entered(area):
	if area == global.playerHitbox:
		if global.playerMax == false:
			print("eliminating")
			await get_tree().create_timer(0.5).timeout
			self.queue_free()
		elif global.playerMax:
			print("max")
