extends State

@export var state_move	: State

var animation_finished = false


func EnterState():
	animation_finished = false
	if !( entity.GetLedge() or entity.GetWall() ):
		var random = [-1, 1]
		entity.direction.x *= random[randi() % 2]
	else: entity.direction.x *= -1
	var turn = utils.GetDirection( entity.direction.x )
	entity.animation.play( turn + "_turn" )

func Update( delta ):
	entity.ApplyGravity( delta )
	
	if animation_finished:
		animation_finished = false
		return state_move

func Move():
	entity.velocity.x = entity.speed * entity.direction.x

func _on_enemy_anim_animation_finished( anim_name ):
	if anim_name == "left_turn" or anim_name == "right_turn":
		animation_finished = true
