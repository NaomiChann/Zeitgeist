extends State

@export var state_move	: State
@export var state_jump	: State
@export var state_fall	: State
@export var state_slide	: State
@export var state_stun	: State
@export var state_crouch	: State

func EnterState():
	entity.speed = entity.BASE_SPEED
	entity.velocity.x = 0
	entity.animation.play( "idle" )
	entity.SetTrail( false )


func Update( delta ):
	entity.ApplyGravity( delta )
	
	if entity.attacking:
		if entity.animation_attack.current_animation == "attack/attack":
			entity.animation.play( "attack" )
		elif entity.animation_attack.current_animation == "attack/attack_2":
			entity.animation.play( "attack_2" )
	elif entity.animation.current_animation != "idle" :
		entity.animation.play( "idle" )
	
	if entity.incapacitated:
		return state_stun
	
	if entity.state_machine_combat.current_state.name != "st_attack":
		if entity.inputDirection.x != 0:
			return state_move
		
		if entity.inputJumpStart == true:
			return state_jump
		
		if entity.velocity.y > 0:
			return state_fall
		
		if entity.inputSlideStart:
			return state_slide
		
		if entity.inputDirection.y == -1:
			return state_crouch
	
	return null
