extends CharacterBody2D

@onready var anim_sprite = $AnimatedSprite2D

func _on_pickup_area_entered(area):
	if area == global.playerHitbox:
		anim_sprite.play("pickup")
		await get_tree().create_timer(.5).timeout
		self.queue_free()
