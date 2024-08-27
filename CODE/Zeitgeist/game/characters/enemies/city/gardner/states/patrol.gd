extends State

const TILE = 16

@export var state_idle	: State
@export var state_attack	: State
@export var timer	: Timer

var destination : Vector2
var timeout = false
var duration = 1.5

func EnterState():
	var random = [-1, 1]
	var vert = random[randi() % 2] * ( 8 + randi() % 3 ) * TILE
	var hori = random[randi() % 2] * ( 8 + randi() % 3 ) * TILE
	
	timeout = false
	
	destination = entity.starting_position + Vector2( vert, hori )
	entity.direction = ( destination - entity.global_position ).normalized()
	
	entity.animation.play( "move" )
	timer.start( maxf( entity.direction.x, entity.direction.y ) * duration )

func Update( _delta ):
	Move()
	
	if Time.get_ticks_msec() % 15 <= 2 and entity.CheckOverlaps():
		return state_attack
	
	if timeout:
		return state_idle

func Move():
	entity.velocity = entity.speed * entity.direction
	if entity.velocity.x != 0:
		entity.sprites.scale.x = sign( entity.velocity.x )

func _on_patrol_timer_timeout():
	timeout = true
