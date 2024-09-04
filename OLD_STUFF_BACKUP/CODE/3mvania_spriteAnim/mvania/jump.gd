extends "state.gd"

func EnterState():
	player.velocity.y = player.JUMP_VELOCITY

func Update( delta ):
	player.ApplyGravity( delta )
	PlayerMove()
	
	if player.velocity.y > 0 or not player.inputJump:
		player.velocity.y /= 4
		return states.fall
	
	return null
