extends State

@export var state_idle	: State
@export var timer	: Timer

var duration = 0.8
var timeout = false
var player_detected = false

func EnterState():
	entity.animation.play_backwards( "wake" )
	timeout = false
	player_detected = false
	entity.vulnerable = false

func Update( delta ):
	entity.ApplyGravity( delta )
	
	if !player_detected and Time.get_ticks_msec() % 15 <= 2 and entity.CheckOverlaps():
		player_detected = true
		PlayerDetected()
	
	if timeout:
		return state_idle

func PlayerDetected():
	entity.animation.play( "wake" )
	timer.start( duration )

func _on_wake_timer_timeout():
	timeout = true
