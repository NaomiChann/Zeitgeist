extends "state.gd"

func EnterState():
	player.speed = player.BASE_SPEED
	player.velocity.x = 0

func Update( delta ):
	player.ApplyGravity( delta )
	
	if player.inputDirection.x != 0:
		return states.move
	
	if player.inputJumpStart == true:
		return states.jump
	
	if player.velocity.y > 0:
		return states.fall
	
	if player.inputSlideStart:
		return states.slide
	
	return null
