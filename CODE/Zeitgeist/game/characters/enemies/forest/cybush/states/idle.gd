extends State

@export var state_turn	: State
@export var state_sleep	: State
@export var timer	: Timer

var duration = 1.0
var idle_timeout = false
var sleep_timeout = false

func EnterState():
	entity.velocity.x = 0
	entity.animation.play( "idle" )
	timer.start( duration )
	idle_timeout = false
	sleep_timeout = false
	entity.vulnerable = true

func Update( delta ):
	entity.ApplyGravity( delta )
	
	if idle_timeout and !sleep_timeout:
		if entity.times_idled > 0 and randi() % 15 == 0:
			entity.times_idled = 0
			timer.start( 1.4 )
			entity.animation.play_backwards( "wake" )
			sleep_timeout = true
		else:
			entity.times_idled += 1
			return state_turn
	elif !idle_timeout and sleep_timeout:
		return state_sleep

func _on_idle_timer_timeout():
	idle_timeout = true
	if sleep_timeout:
		idle_timeout = false
