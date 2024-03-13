extends "state.gd"

func EnterState():
	player.speed = player.BASE_SPEED

func Update( delta ):
	player.velocity.y = 50
	PlayerMove()
	
	if player.is_on_floor():
		return states.idle
	
	if not player.GetWall() or ( player.GetWall().x != player.inputDirection.x ):
		return states.fall
	
	if player.inputJumpStart:
		if player.inputSlide:
			player.speed = player.BASE_SPEED * 1.5
		return states.wallkick
	
	return null
