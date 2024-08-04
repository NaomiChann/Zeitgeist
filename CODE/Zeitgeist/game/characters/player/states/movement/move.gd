extends State

@export var state_idle	: State
@export var state_jump	: State
@export var state_fall	: State
@export var state_slide	: State
@export var state_stun	: State

var side = ""

func EnterState():
	entity.speed = entity.BASE_SPEED
#	entity.animation.play( "move" )
	entity.animation.play( "idle_move" )

func Update( delta ):
	entity.ApplyGravity( delta )
	Move()
	side = utils.GetDirection( entity.inputDirection.x )
	
	if entity.animation.current_animation != ( side + "_move" ):
		entity.animation.play( side + "_move" )
	
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
	
	return null
