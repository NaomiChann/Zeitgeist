extends Sprite2D

const STEP_DISTANCE = 4

func _ready():
	event_bus.UpdateMapDisplay.connect( MapMovement )

func MapMovement( new_coordinate : Vector2 ):
	position = new_coordinate * STEP_DISTANCE
	
