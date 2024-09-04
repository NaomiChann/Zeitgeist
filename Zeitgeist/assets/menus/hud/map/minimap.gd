extends SubViewport

const STEP = 8
var map

func _ready():
	event_bus.UpdateDisplayMap.connect( MapMovement )
	map = get_node( "tm_test" )
	map.visible = true

func MapMovement( new_coordinate : Vector2 ):
	var map_pos = Vector2( 4, 2 )
	map_pos.x =  map_pos.x - new_coordinate.x
	map_pos.y =  map_pos.y - new_coordinate.y
	map.global_position = map_pos * STEP
