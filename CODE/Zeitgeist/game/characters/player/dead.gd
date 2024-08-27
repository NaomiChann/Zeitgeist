extends State

@export_file( "*.tscn" ) var title : String
@export var timer : Node
@export var death_audio : AudioStreamPlayer

var duration = 1.0

func EnterState():
	entity.animation.play( "death" )
	timer.start( duration )
	entity.velocity = Vector2.ZERO
	entity.speed = 0
	entity.SetTrail( false )
	death_audio.play()

func Update( delta ):
	entity.ApplyGravity( delta )

func _on_death_timer_timeout() -> void:
	player_state.max_health = 4
	player_state.health = 4
	player_state.animation_frame = 0
	player_state.velocity = Vector2.ZERO
	player_state.speed = 0.0
	player_state.inputSlide = false
	player_state.inputJump = false

	player_state.flag_dash = false

	scene_manager.ChangeMenuScene( title, false )
