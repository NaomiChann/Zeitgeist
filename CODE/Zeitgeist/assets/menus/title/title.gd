extends Control

@export_file var target_room : String
@export var label : Label

func _process( _delta ):
	if Input.is_action_just_pressed( "continue" ):
		if $Label2.visible_ratio < 1:
			$Label2.visible_ratio = 1
		else:
			scene_manager.ChangeMenuScene( target_room )

func _on_timer_timeout() -> void:
	label.visible = !label.visible
