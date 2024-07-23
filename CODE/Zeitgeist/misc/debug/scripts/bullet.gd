extends CharacterBody2D

var speed = 0

func _physics_process(delta):
	var direction = -1
	velocity.x = direction * speed
	
	if speed > 0:
		visible = true
	else:
		visible = false

	move_and_slide()
