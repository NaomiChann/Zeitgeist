extends State

@export var state_idle		: State
@export var state_move		: State
@export var state_stun		: State
@export var state_wallslide	: State
@export var state_wallkick	: State

@export var audio : AudioStreamPlayer

func EnterState():
	entity.animation.play( "peak" )

func Update( delta ):
	entity.ApplyGravity( delta )
	Move()
	
	if entity.incapacitated:
		return state_stun
	
	if entity.is_on_floor():
		audio.play()
		if entity.inputDirection.x == 0:
			return state_idle
		else:
			return state_move
	
	if entity.GetWall() == entity.inputDirection:
		return state_wallslide
	
	if entity.GetWall() and entity.inputJumpStart:
		return state_wallkick
	
	if entity.velocity.y > 150:
		entity.animation.play( "fall" )
	
	return null
