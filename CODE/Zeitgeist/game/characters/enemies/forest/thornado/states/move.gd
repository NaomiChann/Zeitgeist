extends State

@export var state_idle	: State
@export var state_attack	: State
@export var timer	: Timer

var attack = false
var can_idle = false
var duration = 2.0

func EnterState():
	var side = utils.GetDirection( entity.direction.x )
	attack = false
	can_idle = false
	timer.start( duration )
	
	entity.velocity.x = entity.BASE_SPEED * entity.direction.x
	entity.animation.play( side + "_move" )

func Update( delta ):
	entity.ApplyGravity( delta )
	Move()
	
	if Time.get_ticks_msec() % 15 <= 2 and entity.CheckOverlaps():
		return state_attack
	
	if entity.GetWall() or entity.GetLedge() or ( can_idle and randi() % 300 == 0 ):
		return state_idle

func Move():
	entity.velocity.x = entity.speed * entity.direction.x

func _on_frequency_timer_timeout():
	can_idle = true
