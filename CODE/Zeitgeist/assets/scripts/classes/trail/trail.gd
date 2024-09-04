extends Node2D

var arr : Array = []
var speeding = false
var timeout = false
@export var timer : Timer
@export var sprite_upper : AnimatedSprite2D
@export var sprite_lower : AnimatedSprite2D
@onready var parent_upper : AnimatedSprite2D
@onready var parent_lower : AnimatedSprite2D

func _ready() -> void:
	Setup( false )
	parent_upper = get_parent().get_node( "player_spr_upper" )
	parent_lower = get_parent().get_node( "player_spr_lower" )

func _physics_process( _delta: float ) -> void:
	if speeding:
		arr.push_back( get_parent().global_position )
		global_position = global_position.lerp( arr.pop_front(), 0.85 )
		UpdateSprite()
	
	if !timer.is_stopped():
		arr.push_back( get_parent().global_position )
		global_position = global_position.lerp( arr.pop_front(), 1 )
		UpdateSprite()

func UpdateSprite():
	sprite_upper.animation = parent_upper.animation
	sprite_upper.frame = parent_upper.frame
	
	sprite_lower.animation = parent_lower.animation
	sprite_lower.frame = parent_lower.frame

func Setup( status : bool ):
	speeding = status
	
	if status:
		timer.stop()
		global_position = get_parent().global_position
		arr.clear()
		for i in 4:
			arr.push_back( get_parent().global_position )
		
		visible = true
	else:
		timer.start( 0.1 )
	
	if get_child_count() > 3:
		get_child( 3 ).Setup( status )

func _on_trail_timer_timeout() -> void:
	visible = false
