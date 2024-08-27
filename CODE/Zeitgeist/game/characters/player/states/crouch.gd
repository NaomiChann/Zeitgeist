extends State

@export var state_idle	: State
@export var state_slide	: State
@export var state_stun	: State

func EnterState():
	entity.speed = 0
	entity.velocity.x = 0
	entity.animation.play( "crouch" )
	entity.SetTrail( false )

func Update( delta ):
	entity.ApplyGravity( delta )
	
	if entity.incapacitated:
		return state_stun
	if entity.inputDirection.y != -1:
		return state_idle
	if entity.inputSlideStart:
		return state_slide
	
	return null
