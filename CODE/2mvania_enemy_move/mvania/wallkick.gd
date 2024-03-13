extends "jump.gd"

var pushDirection = 1
var duration = 0.12

@onready var timer = $"../../SlideTmr"

func EnterState():
	pushDirection = -player.GetWall().x
	timer.start( duration )
	player.velocity.y = player.JUMP_VELOCITY
	
	if player.inputSlide:
		player.speed = player.SLIDE_SPEED
	else:
		player.speed = player.BASE_SPEED

func Update( delta ):
	player.ApplyGravity( delta )
	PlayerMove()
	
	if timer.time_left > 0:
		player.velocity.x += 2.5 * player.speed * pushDirection
		player.velocity.x = clamp( player.velocity.x, -player.speed, player.speed )
	
	if player.velocity.y > 0 or not player.inputJump:
		player.velocity.y /= 4
		return states.fall
	
	return null
