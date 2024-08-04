class_name Bullet
extends Area2D

@export var speed : int = 20
@export var firing_angle : float

@onready var direction : Vector2
@onready var radius : float

func _physics_process( delta ):
	radius = Butterfly()
	direction = Vector2( radius * cos( firing_angle ), radius * -sin( firing_angle ) )
	position += direction * speed * delta

func Nothing():
	return sin( firing_angle )

func Butterfly():
	return cos( firing_angle ) * 2 * -sin( firing_angle )

func Angel():
	#var first_arg_left = cos( 5 * ( PI - firing_angle ) )
	#var first_arg_right = sin( 7 * ( PI - firing_angle ) )
	#var second_arg = cos( PI - firing_angle )
	#radius = ( first_arg_left + first_arg_right + 1.3 ) / second_arg
	
	return pow( cos( 5 * firing_angle ), 2.0 ) + sin( 3 * firing_angle ) + 0.3

func _on_lifetime_timeout():
	queue_free()
