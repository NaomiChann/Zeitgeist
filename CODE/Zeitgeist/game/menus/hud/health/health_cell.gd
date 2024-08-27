class_name HealthCell
extends Node2D

@export var vessel : AnimatedSprite2D
@export var status : AnimatedSprite2D

func UpdateCell( cell_type : int, filled : bool ):
	vessel.frame = cell_type
	status.frame = cell_type
	
	status.visible = true if filled else false
