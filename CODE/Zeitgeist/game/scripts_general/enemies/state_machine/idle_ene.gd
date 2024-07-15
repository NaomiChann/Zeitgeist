extends State

@export var state_move	: State

var duration = 1
var done = false

@onready var timer = $"../../idle_timer"

func EnterState():
	timer.start( duration )
	entity.velocity.x = 0

func ExitState():
	done = false

func Update( delta ):
	entity.ApplyGravity( delta )
	
	if done:
		return state_move

func _on_idle_timer_timeout():
	done = true
