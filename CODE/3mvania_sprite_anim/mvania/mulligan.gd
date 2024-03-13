extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var olhaDIR = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func update_animation():
	if $RayCastDIR.is_colliding():
		flip()
		$AnimationPlayer.play("SeeU")
	if $RayCastESQ.is_colliding():
		$AnimationPlayer.play("SeeU")
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


