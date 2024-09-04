extends Node2D

@export var bspawn : Node2D
var variance = 0
var dede = 0.1

func _process( delta: float ) -> void:
	variance += dede
	if variance == 1 or variance == -1:
		dede *= -1
	
	bspawn.position.y = position.y + sin( variance )
