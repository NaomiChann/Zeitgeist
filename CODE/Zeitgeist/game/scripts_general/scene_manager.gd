extends Node

var current_scene : Node = null

func _ready():
	var root = get_tree().root
	
	# loaded scene is always the last child, thus child count - 1
	current_scene = root.get_child( root.get_child_count() - 1 )

func ChangeScene( path : NodePath, target_id : int, spawn_point : Vector2 ):
	# waits for node to be idle before removing it
	call_deferred( "DeferredChangeScene", path, target_id, spawn_point )

func DeferredChangeScene( path : NodePath, target_id : int, spawn_point : Vector2 ):
	# replace current scene with new scene
	current_scene.free()
	current_scene = ResourceLoader.load( path ).instantiate()
	
	# load new scene onto the tree
	get_tree().root.add_child( current_scene )
	
	var loading_zones : Array = get_tree().get_nodes_in_group( "LoadingZone" )
	
	# find zone with the targeted id
	for zone : LoadingZone in loading_zones:
		if zone.zone_id == target_id:
			spawn_point += zone.global_position
			break
	
	event_bus.SpawnPlayer.emit( spawn_point )
