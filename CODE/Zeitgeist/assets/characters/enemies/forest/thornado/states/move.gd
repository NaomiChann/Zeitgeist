extends State

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
	
	if CheckPlayer():
		return state_attack
	
	if entity.GetWall() or entity.GetLedge():
		var side = utils.GetDirection( sign( -entity.direction.x ) )
		entity.animation.play( side + "_attack" )

func Move():
	entity.velocity.x = entity.speed * entity.direction.x

func CheckPlayer():
	$"../../player_detector".force_raycast_update()
	if $"../../player_detector".is_colliding():
		return true
	
	return false
