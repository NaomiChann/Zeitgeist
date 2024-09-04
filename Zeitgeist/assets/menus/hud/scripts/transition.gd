extends CanvasLayer

@export var anim : AnimationPlayer
@export var label : Label

func TransitionOut():
	PlayTransition( "fade", "out" )

func TransitionIn():
	PlayTransition( "fade", "in" )

func PlayTransition( type : String, mode : String ):
	match mode:
		"out":
			anim.play( type )
		"in":
			event_bus.Resume.emit( true )
			anim.play_backwards( type )
		_:
			return
