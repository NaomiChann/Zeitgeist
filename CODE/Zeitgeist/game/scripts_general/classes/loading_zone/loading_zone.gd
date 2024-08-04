class_name LoadingZone
extends Area2D

enum { horizontal, vertical }

@export_category( "Zone Properties" )
@export var zone_id : int
@export_enum( "Horizontal", "Vertical" ) var transition_direction : int

@export_category( "Target Properties" )
@export var target_id : int
@export_file var target_room : String

@onready var spawn_margin : float = min( abs( scale.x ), abs( scale.y ) ) * 16 + 8

var spawn_point : Vector2

func _ready():
	get_node( "db_stats" ).queue_free()

func GetCollisionPoint( player : Node2D ):
	var collision_point = player.global_position - global_position
	
	if transition_direction == horizontal:
		spawn_margin *= sign( -collision_point.x )
		spawn_point = Vector2( spawn_margin, collision_point.y )
	else:
		spawn_margin += 8
		spawn_margin *= sign( -collision_point.y )
		spawn_point = Vector2( collision_point.x, spawn_margin )
	
	event_bus.OnLoadzoneTriggered.emit( "fade" )
	
	await event_bus.TransitionFinished
	scene_manager.ChangeScene( target_room, target_id, spawn_point )
