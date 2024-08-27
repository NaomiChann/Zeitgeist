extends State

@export var state_idle	: State
@export var timer	: Timer

var timeout = false
var duration = 1.0
var target : Vector2

func EnterState():
	timeout = false
	
	target = ( entity.last_seen_target - entity.global_position ).normalized()
	
	timer.start( duration )
	entity.animation.play( "move" )

func Update( _delta ):
	Move()
	
	if timeout:
		return state_idle

func Move():
	entity.velocity = entity.speed * 3.0 * target
	if entity.velocity.x != 0:
		entity.sprites.scale.x = sign( entity.velocity.x )

func _on_chase_timer_timeout():
	timeout = true
