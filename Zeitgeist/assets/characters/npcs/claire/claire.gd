extends CharacterBody2D

func _ready() -> void:
	$item_message.visible = false
	$AnimationPlayer.play( "new_animation" )

func _on_area_2d_area_entered(area: Area2D) -> void:
	var display_txt : String
	$Timer.start()
	$item_message.visible = true
	
	display_txt = "Thank you for playing"
	$item_message/item_message_lbl.text = display_txt
