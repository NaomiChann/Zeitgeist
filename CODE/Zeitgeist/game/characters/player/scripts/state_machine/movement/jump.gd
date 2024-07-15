extends State

@export var state_fall	: State
@export var state_stun	: State

func EnterState():
	entity.velocity.y = entity.JUMP_VELOCITY
#	entity.animation.play( "jump" )
	entity.animation.play( "idle_move" )

func Update( delta ):
	entity.ApplyGravity( delta )
	Move()
	
	if entity.incapacitated:
		return state_stun
	
	if entity.velocity.y > 0 or not entity.inputJump:
		entity.velocity.y /= 4
		return state_fall
	
	return null
