extends "state.gd"

func EnterState():
	player.speed = player.BASE_SPEED

func Update( delta ):
	player.ApplyGravity( delta )
	PlayerMove()
	
	if player.velocity.x == 0:
		return states.idle
	
	if player.velocity.y > 0:
		return states.fall
	
	if player.inputJumpStart:
		return states.jump
	
	if player.inputSlideStart:
		return states.slide
	
	return null
