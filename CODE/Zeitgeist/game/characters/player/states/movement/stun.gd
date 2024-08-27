extends State

@export var state_fall	: State
@export var state_dead	: State

@export var timer : Node
@export var hurt_audio : AudioStreamPlayer

var stunned = false
var duration = 0.5

func EnterState():
	stunned = true
	timer.start( duration )
	entity.animation.play( "stun" )
	entity.velocity = Vector2( entity.impactDirection * entity.BASE_SPEED, -50 )
	entity.SetTrail( false )
	hurt_audio.play()

func Update( delta ):
	entity.ApplyGravity( delta )
	entity.velocity.x /= 1.2
	
	if !stunned:
		if entity.health <= 0:
			return state_dead
		else:
			entity.incapacitated = false
			return state_fall

func _on_stun_timer_timeout():
	stunned = false
	entity.velocity.x = 0
