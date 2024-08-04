extends State

@export var state_idle		: State
@export var state_move		: State
@export var state_stun		: State
@export var state_wallslide	: State
@export var state_wallkick	: State

func Update( delta ):
	entity.ApplyGravity( delta )
#	entity.animation.play( "fall" )
	entity.animation.play( "idle_move" )
	Move()
	
	if entity.incapacitated:
		return state_stun
	
	if entity.is_on_floor():
		if entity.inputDirection.x == 0:
			return state_idle
		else:
			return state_move
	
	if entity.GetWall() == entity.inputDirection:
		return state_wallslide
	
	if entity.GetWall() and entity.inputJumpStart:
		return state_wallkick
	
	return null
