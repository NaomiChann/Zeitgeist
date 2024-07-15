extends State

@export var state_idle	: State

var side = ""

func EnterState():
	entity.direction.x *= -1
	entity.velocity.x = entity.BASE_SPEED * entity.direction.x
	side = utils.GetDirection( entity.direction.x )
	entity.animation.play( side + "_move" )

func Update( delta ):
	entity.ApplyGravity( delta )
	Move()
	
	if entity.GetWall() or entity.GetLedge():
		return state_idle

func Move():
	entity.velocity.x = entity.speed * entity.direction.x
