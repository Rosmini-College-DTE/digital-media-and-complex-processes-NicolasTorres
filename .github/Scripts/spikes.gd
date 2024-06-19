extends CharacterBody2D

class_name Spikes

@onready var deal_damage_zone = $SpikesDamageArea

var damage_to_deal = 33


func _ready():
	global.spikeDamageAmount = damage_to_deal
	global.spikeDamageZone = deal_damage_zone 
