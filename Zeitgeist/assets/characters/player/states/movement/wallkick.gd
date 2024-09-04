extends State

@export var state_fall	: State
@export var state_stun	: State
@export var state_jump	: State

@export var timer : Node

var pushDirection : int
var duration = 0.12

func EnterState():
	$"../../jump_audio2".play()
	pushDirection = -entity.GetWall().x
	timer.start( duration )
	entity.velocity.y = entity.JUMP_VELOCITY
	
	if entity.inputSlide:
		entity.speed = entity.SLIDE_SPEED
		entity.SetTrail( true )

	else:
		entity.speed = entity.BASE_SPEED
	
	entity.animation.play( "wallkick" )

func Update( delta ):
	entity.ApplyGravity( delta )
	Move()
	if entity.incapacitated:
		return state_stun
		
	if entity.inputDirection.x == pushDirection and entity.animation.current_animation == "wallkick":
		entity.animation.play( "peak" )
	
	if timer.time_left > 0:
		entity.velocity.x += 2.5 * entity.speed * pushDirection
		entity.velocity.x = clamp( entity.velocity.x, -entity.speed, entity.speed )
	
	if entity.flag_djump and entity.inputJumpStart and entity.can_jump:
		entity.can_jump = false
		return state_jump
	
	if entity.velocity.y > 0 or not entity.inputJump:
		entity.velocity.y /= 4
		return state_fall
	
	return null
