extends State

@export var state_attack	: State

func Update( _delta ):
	if entity.animation.animation_changed:
		entity.animation_attack.play( "attack/" + entity.animation.get_current_animation() )
		entity.animation_attack.seek( entity.animation.current_animation_position, true )
	
	if entity.inputAttack == true and entity.animation.current_animation not in ["slide", "crouch", "crouch_idle"]:
		return state_attack
	
	return null
