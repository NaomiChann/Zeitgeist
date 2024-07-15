extends State

@export var state_attack	: State

func Update( delta ):
	if entity.inputAttack == true:
		return state_attack
	
	return null
