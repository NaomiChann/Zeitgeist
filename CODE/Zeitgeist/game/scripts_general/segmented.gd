extends Node2D

@onready var arm : PathFollow2D
@onready var segments : int = 5
@onready var segment_distance : Vector2 = Vector2.ZERO

@export var arm_seg_scene = preload( "res://arm_segment.tscn" )
@export var arm_drill_scene = preload( "res://arm_drill.tscn" )
var arm_arr : Array
var arm_drill : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	arm = get_node( "arm_curve/arm_points" )
	
	for segment in segments:
		arm_arr.push_back( arm_seg_scene.instantiate() )
		get_tree().root.add_child.call_deferred( arm_arr[segment] )
	
	arm_drill = arm_drill_scene.instantiate()
	get_tree().root.add_child.call_deferred( arm_drill )
	
	$AnimationPlayer.play( "slam_cask" )
	#$AnimationPlayer.play( "slam_ceiling" )
	

func _physics_process( _delta ):
	arm.progress_ratio = 0.0
	
	for segment in segments:
		arm.progress_ratio = ( segment * 0.2 )
		arm_arr[segment].position = arm.position
		arm.progress_ratio += 0.15
		arm_arr[segment].look_at( arm.position )
	
	arm.progress_ratio = 1.0
	arm_drill.position = arm.position
	arm.progress_ratio -= 0.05
	arm_drill.look_at( arm.position )
