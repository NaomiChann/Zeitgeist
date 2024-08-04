extends AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	event_bus.OnLoadzoneTriggered.connect( TransitionOut, CONNECT_ONE_SHOT )
	event_bus.TransitionScreen.connect( PlayTransition, CONNECT_ONE_SHOT )

func TransitionOut( type : String ):
	PlayTransition( type, "out" )

func PlayTransition( type : String, mode : String ):
	match mode:
		"out":
			play( type )
		"in":
			play_backwards( type )
		_:
			return
	
	await animation_finished
	event_bus.TransitionFinished.emit()
