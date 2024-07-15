extends State

@export var state_idle		: State
@export var state_fall		: State
@export var state_wallkick	: State

func EnterState():
	entity.speed = entity.BASE_SPEED

func Update( delta ):
	entity.velocity.y = 50
	Move()
	
	if entity.is_on_floor():
		return state_idle
	
	if not entity.GetWall() or ( entity.GetWall().x != entity.inputDirection.x ):
		return state_fall
	
	if entity.inputJumpStart:
		if entity.inputSlide:
			entity.speed = entity.BASE_SPEED * 1.5
		return state_wallkick
	
	return null
