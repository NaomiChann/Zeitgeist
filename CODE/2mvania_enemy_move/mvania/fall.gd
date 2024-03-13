extends "state.gd"

func Update( delta ):
	player.ApplyGravity( delta )
	PlayerMove()
	
	if player.is_on_floor():
		if player.inputDirection.x == 0:
			return states.idle
		else:
			return states.move
	
	if player.GetWall() == player.inputDirection:
		return states.wallslide
	
	if player.GetWall() and player.inputJumpStart:
		return states.wallkick
	
	return null
