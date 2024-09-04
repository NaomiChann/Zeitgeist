class_name Bullet
extends Area2D

@export var speed : float = 40.0
@export var firing_angle : float

@onready var direction : Vector2
@onready var radius : float
var decrease = 0.0001

var sig = [-1, 1]

func _physics_process( delta ):
	speed *= 1.05
	position += Vector2.LEFT * speed * delta

func HOTFElectric( delta ):
	radius = Lightning()
	direction = Vector2( radius * cos( firing_angle ) + ( sig[randi() % 2] * randi() % 10 ), 
						( radius * -sin( firing_angle ) + ( sig[randi() % 2] * randi() % 5 ) ) / 3 )
	speed = clamp( speed - ( decrease * delta ), 10, 40 )
	position += direction * speed * delta

func Nothing():
	return sin( firing_angle )

func Butterfly():
	return cos( firing_angle ) * 2 * -sin( firing_angle )

func Lightning():
	return sin( firing_angle ) + pow( sin( 5 * ( firing_angle / 2 ) ), 3 )

func Angel():
	#var first_arg_left = cos( 5 * ( PI - firing_angle ) )
	#var first_arg_right = sin( 7 * ( PI - firing_angle ) )
	#var second_arg = cos( PI - firing_angle )
	#radius = ( first_arg_left + first_arg_right + 1.3 ) / second_arg
	
	return pow( cos( 5 * firing_angle ), 2.0 ) + sin( 3 * firing_angle ) + 0.3

func _on_lifetime_timeout():
	queue_free()
