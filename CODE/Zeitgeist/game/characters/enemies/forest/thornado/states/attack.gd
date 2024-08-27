extends State

@export var state_idle	: State
@export var projectile : Node2D

var target : Vector2
var pos : Vector2

func EnterState():
	entity.velocity.x = 0
	var side = utils.GetDirection( sign( ( target - entity.global_position ).x ) )
	entity.animation.play( side + "_attack" )

func Update( delta ):
	entity.ApplyGravity( delta )
	
	if !fired:
		if entity.animation.current_animation_position >= 0.25:
			fired = true
			projectile.Shoot( pos, target )
	elif entity.animation.current_animation_position >= 0.35:
		return state_idle
