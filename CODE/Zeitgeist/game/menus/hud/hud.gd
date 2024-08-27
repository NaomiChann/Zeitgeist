extends Control

var can_skip = false

func _ready() -> void:
	event_bus.ItemPickup.connect( ItemMessage )

func _process( _delta: float ) -> void:
	if $hud_canvas/item_message.visible == true and can_skip and Input.is_action_just_pressed( "jump" ):
		can_skip = false
		$hud_canvas/item_message.visible = false
		$hud_canvas/item_message/item_message_bg.scale.y = 1
		get_tree().paused = false

func ItemMessage( type, upgrade ):
	if type != utils.Pickup.HEAL:
		var display_txt : String
		get_tree().paused = true
		$Timer.start()
		$hud_canvas/item_message.visible = true
		$AudioStreamPlayer2D.play()
		
		match upgrade:
			0:
				display_txt = "Health Augment"
			2:
				$hud_canvas/item_message/item_message_bg.scale.y *= 2
				display_txt = "Sliding Augment\n\nPress E or Z to slide"
			_:
				display_txt = "REPORT THIS BUG"
		
		$hud_canvas/item_message/item_message_lbl.text = display_txt


func _on_timer_timeout() -> void:
	can_skip = true
