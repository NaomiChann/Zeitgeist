extends Control

var can_skip = false

func _ready() -> void:
	event_bus.ItemPickup.connect( ItemMessage )

func _process( _delta: float ) -> void:
	if $hud_canvas/item_message.visible == true and can_skip and Input.is_action_just_pressed( "continue" ):
		can_skip = false
		$hud_canvas/item_message.visible = false
		$hud_canvas/item_message/item_message_bg.scale.y = 1
		$AudioStreamPlayer2D.stop()
		get_tree().paused = false

func ItemMessage( type, upgrade ):
	if type != utils.Pickup.HEAL:
		var display_txt : String
		$Timer.start()
		get_tree().paused = true
		$hud_canvas/item_message.visible = true
		$AudioStreamPlayer2D.play()
		
		match upgrade:
			0:
				display_txt = "Health Augment"
			2:
				$hud_canvas/item_message/item_message_bg.scale.y *= 2
				display_txt = "Sliding Augment\n\nPress E or Z to slide"
			3:
				$hud_canvas/item_message/item_message_bg.scale.y *= 2
				display_txt = "Jump Augment\n\nPress jump again on air"
			_:
				display_txt = "REPORT THIS BUG"
		
		$hud_canvas/item_message/item_message_lbl.text = display_txt

func _on_timer_timeout() -> void:
	can_skip = true
