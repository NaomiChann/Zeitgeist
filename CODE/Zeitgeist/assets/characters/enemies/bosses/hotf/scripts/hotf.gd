extends CharacterBody2D

@export var sprite : AnimatedSprite2D
@export var particles : CPUParticles2D
@export var collision : CollisionShape2D
@export var cask_area : Area2D

var health = 3

func _on_cask_obj_area_entered(area: Area2D) -> void:
	if area.name == "arm_drill_area":
		sprite.frame += 1
		health -= 1
		particles.emitting = true
		if health == 0:
			collision.queue_free()
			event_bus.BossDead.emit()
