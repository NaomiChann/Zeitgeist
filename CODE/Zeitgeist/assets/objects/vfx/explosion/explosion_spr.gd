extends Node2D

@export var grass : bool = false

func _ready() -> void:
	$explosion_anim.play( "explode" )
	if grass:
		$explosion_part.emitting = true

func _on_leaves_part_finished() -> void:
	queue_free()
