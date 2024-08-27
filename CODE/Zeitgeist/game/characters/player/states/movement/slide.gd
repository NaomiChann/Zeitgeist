extends State

@export var state_idle	: State
@export var state_move	: State
@export var state_jump	: State
@export var state_fall	: State
@export var state_stun	: State
@export var state_crouch	: State

@export var timer : Timer
@export var smoke : CPUParticles2D
@export var audio : AudioStreamPlayer

var duration = 0.5
var side = ""

func EnterState():
	entity.sliding = true
	entity.speed = entity.SLIDE_SPEED
	timer.start( duration )
	entity.animation.play( "slide" )
	smoke.restart()
	smoke.emitting = true
	
	if entity.inputDirection.y != 0:
		entity.slideDirection = entity.inputDirection
	else:
		entity.slideDirection = entity.lastDirection
	entity.velocity.x = entity.slideDirection.normalized().x * entity.speed
	
	entity.SetTrail( true )
	audio.play( 0.2)

func Update( delta ):
	entity.ApplyGravity( delta )
	
	if !entity.inputSlide:
		entity.sliding = false
	
	if !entity.GetCeiling():
		Move()
		
		# will generate a bug when getting damaged sliding under low ceiling
		if entity.incapacitated:
			return state_stun
		
		if entity.inputJumpStart:
			return state_jump
		
		if !entity.sliding and entity.is_on_floor():
			if entity.inputDirection.y == 1:
				return state_crouch
			elif entity.inputDirection.x == 0:
				return state_idle
			else:
				return state_move
		
		# torn between leaving this as a feature or not
		#if entity.sliding and !entity.is_on_floor():
		if !entity.is_on_floor():
			return state_fall
	
	return null

func ExitState():
	smoke.emitting = false

func Move():
	entity.velocity.x = entity.speed * entity.lastDirection.x
	if entity.inputDirection.x != 0:
		entity.sprites.scale.x = entity.inputDirection.x
		entity.lastDirection = entity.inputDirection

func _on_timer_timeout():
	entity.sliding = false
