extends State

@export var state_fall	: State
@export var state_stun	: State

func EnterState():
	$"../../jump_audio2".play()
	entity.velocity.y = entity.JUMP_VELOCITY
	entity.animation.play( "jump" )

func Update( delta ):
	entity.ApplyGravity( delta )
	Move()
	
	if entity.incapacitated:
		return state_stun
	
	if entity.velocity.y > -150 and entity.animation.current_animation != "peak":
		entity.animation.play( "peak" )
	
	if entity.velocity.y > 0 or not entity.inputJump:
		entity.velocity.y /= 4
		return state_fall
	
	if entity.flag_djump and entity.inputJumpStart and entity.can_jump:
		$"../../jump_audio2".play()
		entity.velocity.y = entity.JUMP_VELOCITY
		entity.animation.play( "jump" )
		entity.can_jump = false
	
	return null
