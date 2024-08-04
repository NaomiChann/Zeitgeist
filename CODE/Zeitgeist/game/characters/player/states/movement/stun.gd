extends State

@export var state_fall	: State

@export var timer : Node

var stunned = false
var duration = 0.5

func EnterState():
	stunned = true
	timer.start( duration )
	entity.animation.play( "left_dash" )
	entity.velocity = Vector2( entity.impactDirection * entity.BASE_SPEED, -50 )

func Update( delta ):
	entity.ApplyGravity( delta )
	entity.velocity.x /= 1.2
	
	if !stunned:
		return state_fall

func ExitState():
	entity.incapacitated = false

func _on_stun_timer_timeout():
	stunned = false
	entity.velocity.x = 0
