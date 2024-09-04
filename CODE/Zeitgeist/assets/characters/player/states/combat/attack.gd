extends State

@export var state_rest	: State

@export var timer : Timer
@export var audio : AudioStreamPlayer2D
@export var hitboxAttack : Node
@export var hitboxAttack2 : Node

var duration = 0.3
var combo_status = 0

func EnterState():
	combo_status = 0
	Combo()
	entity.attacking = true

func Update( _delta ):
	if entity.inputAttack:
		Combo()
	
	if !entity.attacking:
		entity.animation_attack.play( "attack/" + entity.state_machine.current_state.name.right( -3 ) )
		entity.animation_attack.seek( entity.animation.current_animation_position, true )
		
		return state_rest
	
	return null

func Combo():
	var valid = true
	if !entity.is_on_floor():
		combo_status = 1
	
	match combo_status:
		0:
			entity.animation_attack.play( "attack/attack" )
		1:
			entity.animation_attack.play( "attack/attack_2" )
		_:
			valid = false
	
	if valid:
		audio.play()
		combo_status += 1
		timer.start( duration )

func _on_attack_timer_timeout():
	entity.attacking = false
