extends CharacterBody2D

@onready var anim_sprite = $AnimatedSprite2D

func _on_pickup_area_entered(area):
	if area == global.playerHitbox:
		state.obtained = true
		anim_sprite.play("pickup")
		$Pickup/CollisionShape2D.hide()
		$Obtain.play()
		await get_tree().create_timer(.5).timeout
		$Light.hide()
		await get_tree().create_timer(2).timeout
		self.queue_free()
