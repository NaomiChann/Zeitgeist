extends State

@export var state_idle	: State
@export var projectile : Node2D

var target : Vector2
var pos : Vector2
var fired = false

func EnterState():
	fired = false
	entity.velocity.x = 0
	target = entity.last_seen_target
	pos = target - entity.global_position
	var side = utils.GetDirection( sign( ( target - entity.global_position ).x ) )
	entity.animation.play( side + "_attack" )

func Update( delta ):
	entity.ApplyGravity( delta )
	
	if !fired:
		if entity.animation.current_animation_position >= 0.25:
			fired = true
			projectile.Shoot( pos, target )
			$"../../AudioStreamPlayer2D".play()
	elif entity.animation.current_animation_position >= 0.35:
		return state_idle
