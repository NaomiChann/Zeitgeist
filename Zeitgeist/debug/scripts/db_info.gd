@tool
extends Node2D

@onready var zone : LoadingZone = get_parent()
@onready var label : Label = get_child( 0 )

func _draw():
	UpdateDebugDisplay()

func UpdateDebugDisplay():
	if !Engine.is_editor_hint():
		return
	
	var field_1 : String = "[{0}]".format( [zone.zone_id] )
	var field_2 : String = "->[{0}] \n".format( [zone.target_id] )
	var field_3 : String = "in {0}".format( [zone.target_room.get_file().rstrip( ".tscn" )] )
	
	label.text = field_1 + field_2 + field_3
