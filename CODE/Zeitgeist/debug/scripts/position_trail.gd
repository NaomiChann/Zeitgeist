extends Line2D

@export var tracked : Node2D

@onready var curve := Curve2D.new()

func _process(delta):
	curve.add_point( tracked.position )
	points = curve.get_baked_points()
