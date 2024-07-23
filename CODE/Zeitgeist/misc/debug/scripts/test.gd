extends Area2D

@export var vertical : bool

func _ready():
	print( global_position )

func _on_body_entered(body):
	var phit = body.global_position - global_position
	if vertical:
		phit *= Vector2( -1, 1 )
	else:
		phit *= Vector2( 1, -1 )
	body.global_position = $"../Area2D2".global_position + phit
