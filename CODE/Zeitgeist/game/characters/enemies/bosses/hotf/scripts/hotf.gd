extends Area2D

var health = 3

func _on_area_entered(area):
	if area.name == "arm_drill":
		$Icon.frame += 1
		health -= 1
		$CPUParticles2D.emitting = true
		if health == 0:
			$CollisionShape2D.queue_free()
