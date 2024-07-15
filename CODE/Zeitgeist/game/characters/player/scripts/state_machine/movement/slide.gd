extends State

@export var state_idle	: State
@export var state_move	: State
@export var state_jump	: State
@export var state_fall	: State
@export var state_stun	: State

@export var timer : Node

var duration = 0.5
var side = ""

func EnterState():
	entity.sliding = true
	entity.speed = entity.SLIDE_SPEED
	timer.start( duration )
	entity.animation.play( utils.GetDirection( entity.lastDirection.x ) + "_dash" )
	
	if entity.inputDirection.y != 0:
		entity.slideDirection = entity.inputDirection
	else:
		entity.slideDirection = entity.lastDirection
	entity.velocity.x = entity.slideDirection.normalized().x * entity.speed

func Update( delta ):
	entity.ApplyGravity( delta )
	
	if entity.GetCeiling():
		return null
	else:
		Move()
		side = utils.GetDirection( entity.lastDirection.x )
	
		if entity.animation.current_animation != ( side + "_dash" ):
			entity.animation.play( side + "_dash" )
	
	# will generate a bug when getting damaged sliding under low ceiling
	if entity.incapacitated:
		return state_stun
	
	if entity.inputJumpStart:
		return state_jump
	
	if not entity.inputSlide:
		entity.sliding = false
	
	if not entity.sliding and entity.is_on_floor():
		if entity.inputDirection.x == 0:
			return state_idle
		else:
			return state_move
	elif entity.sliding and not entity.is_on_floor():
		return state_fall
	
	return null

func Move():
	entity.velocity.x = entity.speed * entity.lastDirection.x
	if entity.inputDirection.x != 0:
		entity.lastDirection = entity.inputDirection

func _on_timer_timeout():
	entity.sliding = false
