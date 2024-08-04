extends State

@export var state_attack	: State

func Update( _delta ):
	if entity.inputAttack == true:
		return state_attack
	
	return null
