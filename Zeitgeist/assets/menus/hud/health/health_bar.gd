class_name HealthBar
extends Node2D

const CELL_SIZE = 13

@export_file( "*.tscn" ) var cell_scene : String

@onready var health_bar : Array = []

func _ready():
	for point in player_state.max_health:
		IncreaseSize()
	
	UpdateBar( player_state.health )
	
	event_bus.UpdateDisplayHealth.connect( UpdateBar )

func IncreaseSize():
	var size := health_bar.size()
	
	health_bar.push_back( ResourceLoader.load( cell_scene ).instantiate() )
	add_child( health_bar[size] )
	
	health_bar[size].position.x = size * CELL_SIZE

# starting_point = 0 to fully update
func UpdateBar( health_cur : int, increase : bool = false ) -> void:
	if increase:
		IncreaseSize()
	
	for cell in health_bar.size():
		var cell_type := GetType( cell )
		var filled := true if cell < health_cur else false
		
		health_bar[cell].UpdateCell( cell_type, filled )

func GetType( cell : int ) -> int:
	var cell_type : int
	var limit := health_bar.size() - 1
	
	match cell:
		0:
			cell_type = utils.Segment.HEAD
		limit:
			cell_type = utils.Segment.TAIL
		_:
			cell_type = utils.Segment.BODY
	
	return cell_type
