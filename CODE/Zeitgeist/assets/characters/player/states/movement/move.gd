extends State

@export var state_idle	: State
@export var state_jump	: State
@export var state_fall	: State
@export var state_slide	: State
@export var state_stun	: State
@export var state_crouch	: State

var side = ""

func EnterState():
	entity.speed = entity.BASE_SPEED
	entity.animation.play( "move" )
	entity.SetTrail( false )
	entity.can_jump = true

func Update( delta ):
	entity.ApplyGravity( delta )
	Move()
	
	if entity.incapacitated:
		return state_stun
	
	if entity.velocity.x == 0:
		return state_idle
	
	if entity.velocity.y > 0:
		return state_fall
	
	if entity.inputJumpStart:
		return state_jump
	
	if entity.inputSlideStart:
		return state_slide
	
	if entity.inputDirection.y == -1:
		return state_crouch
	return null
