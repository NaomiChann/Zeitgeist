extends State

@export var state_patrol	: State
@export var timer	: Timer

var timeout : bool = false
var duration = 1.0

func EnterState():
	timeout = false
	entity.velocity = Vector2.ZERO

	entity.animation.play( "idle" )
	timer.start( duration )

func ExitState():
	entity.animation.play( "transition" )

func Update( _delta ):
	if timeout:
		return state_patrol

func _on_idle_timer_timeout():
	timeout = true
