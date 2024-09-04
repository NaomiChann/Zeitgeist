extends Node2D

@export var timer : Timer
@export var damage : int

var player_pos : Vector2
var moving_speed : int = 400
var speed = 0
var duration = 1

func _process( delta ):
	global_position += player_pos.normalized() * speed * delta

func Shoot( pos, target ):
	#global_position = get_parent().global_position
	player_pos = pos
	look_at( target )
	speed = moving_speed
	visible = true
	get_node( "laser_hitbox/laser_col" ).disabled = false
	timer.start( duration )

func _on_lifetime_timer_timeout():
	visible = false
	get_node( "laser_hitbox/laser_col" ).disabled = true
	speed = 0
	global_position = get_parent().global_position
