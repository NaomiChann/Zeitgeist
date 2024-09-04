extends Control

@export var label : Label
@export var timer : Timer
@export var sfx : AudioStreamPlayer2D
@export var ratio : float = 0.15
@onready var text_copy : String

var prev_char = 0
var cur_char = 0
var control = true

func _ready() -> void:
	text_copy = label.text

func _process( delta: float ) -> void:
	if label.visible_ratio < 1:
		label.visible_ratio += ratio * delta
		cur_char = label.visible_characters
		if cur_char > prev_char:
			if text_copy[prev_char] not in [" ", ".", ","]:
				sfx.play()
			
			prev_char = cur_char
	
	elif timer.is_stopped():
		$"../Label3".visible = true
		$"../Timer".start( 0.5 )
		timer.start()

func _on_timer_timeout() -> void:
	if control:
		label.text += "-"
	else:
		label.text = text_copy
	
	control = !control
