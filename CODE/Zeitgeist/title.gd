extends Control

@export_file var target_room : String
@export var label : Label
@export var can_continue : bool

func _process( _delta ):
	if can_continue and Input.is_action_just_pressed( "jump" ):
		scene_manager.ChangeMenuScene( target_room )

func _on_timer_timeout() -> void:
	label.visible = !label.visible
