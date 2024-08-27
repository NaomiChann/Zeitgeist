extends Node2D

@export var bullet_scene = preload( "res://game/scripts_general/classes/projectiles/bullet.tscn" )
@export var quantity : int = 25
@export var angle : float = 360.0

@onready var pos_arr : Array = []

var bullet : Node2D = null
var current : int = 0

func _ready() -> void:
	pos_arr.push_back( global_position )
	pos_arr.push_back( global_position - Vector2( 0, 16 ) )
	pos_arr.push_back( global_position + Vector2( 0, 24 ) )

func _on_spawntiimer_timeout():
	if current > 2:
		current = 0
	
	bullet = bullet_scene.instantiate()
	
	get_tree().root.add_child( bullet )
	bullet.global_position = global_position
	global_position = pos_arr[current]
	current += 1
