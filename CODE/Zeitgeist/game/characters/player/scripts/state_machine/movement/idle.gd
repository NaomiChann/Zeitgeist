extends State

@export var state_move	: State
@export var state_jump	: State
@export var state_fall	: State
@export var state_slide	: State
@export var state_stun	: State

func EnterState():
	#super()
	entity.speed = entity.BASE_SPEED
	entity.velocity.x = 0
	entity.animation.play( "idle_move" )

func Update( delta ):
	entity.ApplyGravity( delta )
	
	if entity.incapacitated:
		return state_stun
	
	if entity.inputDirection.x != 0:
		return state_move
	
	if entity.inputJumpStart == true:
		return state_jump
	
	if entity.velocity.y > 0:
		return state_fall
	
	if entity.inputSlideStart:
		return state_slide
	
	return null
