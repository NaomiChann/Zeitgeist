extends State

@export var state_rest	: State

@export var timer : Node
@export var hitboxAttack : Node

var duration = 0.3

func EnterState():
	entity.attacking = true
	timer.start( duration )
	hitboxAttack.disabled = false

func Update( _delta ):
	if !entity.attacking:
		hitboxAttack.disabled = true
		
		return state_rest
	
	return null

func _on_attack_timer_timeout():
	entity.attacking = false
