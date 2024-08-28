extends Node

var loading_screen_scene : String = "res://loading_screen.tscn"
var current_scene : Node = null
var loading_screen : Node = null

func _ready():
	var root = get_tree().root
	# loaded scene is always the last child, thus child count - 1
	current_scene = root.get_child( root.get_child_count() - 1 )
	loading_screen = ResourceLoader.load( loading_screen_scene ).instantiate()
	get_tree().root.add_child.call_deferred( loading_screen )
	event_bus.Resume.connect( PausePlayer )

func ChangeScene( path : NodePath, target_id : int, spawn_point : Vector2 ):
	loading_screen.TransitionOut()
	await loading_screen.anim.animation_finished
	loading_screen.label.visible = true
	
	# waits for node to be idle
	call_deferred( "DeferredChangeScene", path, target_id, spawn_point )

func DeferredChangeScene( path : NodePath, target_id : int, spawn_point : Vector2 ):
	# replace current scene with new scene
	current_scene.free()
	current_scene = ResourceLoader.load( path ).instantiate()
	
	# load new scene onto the tree
	get_tree().root.add_child( current_scene )
	
	var loading_zones : Array = get_tree().get_nodes_in_group( "LoadingZone" )
	var pickups : Array = get_tree().get_nodes_in_group( "Pickup" )
	var player : Player = current_scene.get_node( "player_obj" )
	
	# find zone with the targeted id
	for zone : LoadingZone in loading_zones:
		if zone.zone_id == target_id:
			spawn_point += zone.global_position
			if zone.transition_direction == 1 and player_state.velocity.y < 0:
				player_state.velocity.y = -320.0
			break
	
	var i = 1
	for pickup in pickups:
		pickup.id = i
		i += 1
		if pickup.id in [1, 3, 5]:
			pickup.queue_free()
	
	event_bus.SpawnPlayer.emit( spawn_point )
	
	loading_screen.label.visible = false
	loading_screen.TransitionIn()
	await loading_screen.anim.animation_finished
	PausePlayer( false )

func ChangeMenuScene( path : NodePath, from_title : bool = true ):
	loading_screen.TransitionOut()
	await loading_screen.anim.animation_finished
	loading_screen.label.visible = true
	
	if from_title:
		call_deferred( "DeferredChangeMenuScene", path )
	else:
		ReturnToTitle( path )

func DeferredChangeMenuScene( path : NodePath ):
	current_scene.free()
	current_scene = ResourceLoader.load( path ).instantiate()
	
	get_tree().root.add_child( current_scene )
	
	var player : Player = current_scene.get_node( "player_obj" )
	
	loading_screen.label.visible = false
	loading_screen.TransitionIn()
	await loading_screen.anim.animation_finished
	PausePlayer( false )

func ReturnToTitle( path : NodePath ):
	current_scene.free()
	current_scene = ResourceLoader.load( path ).instantiate()
	
	get_tree().root.add_child( current_scene )
	
	loading_screen.label.visible = false
	loading_screen.TransitionIn()
	await loading_screen.anim.animation_finished

func PausePlayer( status : bool = true ):
	var player : Player = current_scene.get_node( "player_obj" )
	if player:
		player.set_process( !status )
		player.set_process_input( !status )
		player.set_process_internal( !status )
		player.set_process_unhandled_input( !status )
		player.set_process_unhandled_key_input( !status )
	
