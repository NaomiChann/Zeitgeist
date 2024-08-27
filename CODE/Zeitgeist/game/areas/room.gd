@icon( "res://game/scripts_general/classes/class_icons/room.svg" )
class_name Room
extends Node2D

@export var room_coordinates : Vector2
@export var room_size : Vector2 = Vector2( 1, 1 )
@export var room_size_tiles : Vector2 = Vector2( 3, 3 )
@export var camera : Camera2D
@export var custom : bool = false

func _ready():
	if !custom:
		camera.limit_right = 480 * int( room_size.x )
		camera.limit_bottom = 480 * int( room_size.y )
	else:
		camera.limit_right = 32 * int( room_size_tiles.x )
		camera.limit_bottom = 32 * int( room_size_tiles.y )
