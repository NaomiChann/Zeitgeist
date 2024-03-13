extends "state.gd"

var duration = 0.5

@onready var timer = $"../../SlideTmr"
@onready var animation = $"../../AnimationPlayer"

func EnterState():
	player.sliding = true
	player.speed = player.SLIDE_SPEED
	animation.play( "dash" )
	timer.start( duration )
	
	if player.inputDirection.y != 0:
		player.slideDirection = player.inputDirection
	else:
		player.slideDirection = player.lastDirection
	player.velocity.x = player.slideDirection.normalized().x * player.speed

func ExitState():
	animation.play( "idle" )
	player.sliding = false

func Update( delta ):
	player.ApplyGravity( delta )
	PlayerMove()
	
	if player.inputJumpStart:
		return states.jump
	
	if not player.inputSlide:
		player.sliding = false
	
	if not player.sliding and player.is_on_floor():
		if player.inputDirection.x == 0:
			return states.idle
		else:
			return states.move
	elif player.sliding and not player.is_on_floor():
		return states.fall
	
	return null

func PlayerMove():
	player.velocity.x = player.speed * player.lastDirection.x
	if player.inputDirection.x != 0:
		player.lastDirection = player.inputDirection

func _on_timer_timeout():
	player.sliding = false
