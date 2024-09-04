extends State

@export var state_move	: State
@export var projectile : Node2D

var target : Vector2
var pos : Vector2
var fired : bool = false

func EnterState():
	fired = false
	entity.velocity.x = 0
	var side = utils.GetDirection( sign( ( target - entity.global_position ).x ) )
	entity.animation.play( side + "_attack" )

func Update( delta ):
	entity.ApplyGravity( delta )
	
	if fired:
		return state_move

func _on_timer_timeout() -> void:
	fired = true
