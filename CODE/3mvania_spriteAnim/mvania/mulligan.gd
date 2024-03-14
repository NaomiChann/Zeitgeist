extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var olhaDIR = false
var collision = false
var attack = false

func update_animation():
	if $RayCastDIR.is_colliding():
		flip()
		$AnimationPlayer.play("SeeU")
		
	elif $RayCastESQ.is_colliding():
		$AnimationPlayer.play("SeeU")
		
	elif collision == true:
		attack = true
		$AnimationPlayer.play("attack")
		
	else:
		$AnimationPlayer.play("idle")

func flip():
	olhaDIR = !olhaDIR
	scale.x = abs(scale.x) * -1


func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
	#	velocity.x = direction * SPEED
	#else:
	#	velocity.x = move_toward(velocity.x, 0, SPEED)
	update_animation()
	move_and_slide()



func _on_area_2d_area_entered(area):
	$AnimationPlayer.play("attack")
	#print("AAAAAAAAAA")
	collision = true
