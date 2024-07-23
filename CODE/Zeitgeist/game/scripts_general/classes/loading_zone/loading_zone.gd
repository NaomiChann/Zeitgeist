class_name LoadingZone
extends Area2D

enum { horizontal, vertical }

@export_category( "Zone Properties" )
@export var zone_id : int
@export_enum( "Horizontal", "Vertical" ) var transition_direcion : int

@export_category( "Target Properties" )
@export var target_id : int
@export_file var target_room : String

@onready var spawn_margin : float = min( abs( scale.x ), abs( scale.y ) ) * 16 + 8

var spawn_point : Vector2

func GetCollisionPoint( player : Node2D ):
	var collision_point = player.global_position - global_position
	
	if transition_direcion == horizontal:
		spawn_margin *= sign( -collision_point.x )
		spawn_point = Vector2( spawn_margin, collision_point.y )
	else:
		spawn_margin *= sign( -collision_point.y )
		spawn_point = Vector2( collision_point.x, spawn_margin )
	
	event_bus.OnLoadzoneTriggered.emit()
	scene_manager.ChangeScene( target_room, target_id, spawn_point )
