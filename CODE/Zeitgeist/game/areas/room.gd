@icon( "res://game/scripts_general/classes/class_icons/room.svg" )
class_name Room
extends Node2D

@export var room_coordinates : Vector2
@export var room_size : Vector2 = Vector2( 1, 1 )
@export var camera : Camera2D

func _ready():
	camera.limit_right = 480 * int( room_size.x )
	camera.limit_bottom = 480 * int( room_size.y )
