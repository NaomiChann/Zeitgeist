extends Node2D

@export var bullet_scene = preload( "res://game/scripts_general/classes/projectiles/bullet.tscn" )
@export var quantity : int = 25

var bullet : Node2D = null
@onready var firing_angle : float = 0.0

func _on_spawntiimer_timeout():
	for fire in quantity:
		bullet = bullet_scene.instantiate()
		
		get_tree().root.add_child( bullet )
		bullet.position = position
		bullet.firing_angle = ( 360 / quantity ) * fire
