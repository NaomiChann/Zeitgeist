extends State

@export var state_fall	: State

@export var timer : Node

var pushDirection = 1
var duration = 0.12

func EnterState():
	pushDirection = -entity.GetWall().x
	timer.start( duration )
	entity.velocity.y = entity.JUMP_VELOCITY
	
	if entity.inputSlide:
		entity.speed = entity.SLIDE_SPEED
	else:
		entity.speed = entity.BASE_SPEED

func Update( delta ):
	entity.ApplyGravity( delta )
	Move()
	
	if timer.time_left > 0:
		entity.velocity.x += 2.5 * entity.speed * pushDirection
		entity.velocity.x = clamp( entity.velocity.x, -entity.speed, entity.speed )
	
	if entity.velocity.y > 0 or not entity.inputJump:
		entity.velocity.y /= 4
		return state_fall
	
	return null
