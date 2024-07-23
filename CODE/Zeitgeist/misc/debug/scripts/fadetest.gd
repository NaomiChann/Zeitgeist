extends ColorRect

var shader_material = material
var loaded = true
var entered = false
var gamma = 0.0

func _ready():
	shader_material.set_shader_parameter( "gamma", 0.0 )

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process( delta ):
	if loaded:
		gamma += 5 * delta
		if gamma >= 1.0:
			gamma = 1.0
			loaded = false
		shader_material.set_shader_parameter( "gamma", gamma )
	
	if entered:
		gamma -= 5 * delta
		shader_material.set_shader_parameter( "gamma", gamma )
		if gamma <= 0.0:
			event_bus.parser.emit()
			scene_manager.ChangeScene( "res://misc/debug/room_1.tscn" )


func _on_area_2d_body_entered(body):
	entered = true
