extends CharacterBody2D

class_name KillZone

@onready var deal_damage_zone = $"."

var damage_to_deal = 100000

func _ready():
	global.voidDamageAmount = damage_to_deal
	global.voidDamageZone = deal_damage_zone 

