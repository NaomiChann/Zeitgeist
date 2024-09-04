extends CharacterBody2D

@export var player : Player
@export_file( "*.tscn" ) var spawner : String
@onready var direction : Vector2
var speed = 300
var done = false

func _ready() -> void:
	direction = player.global_position - global_position
	velocity = direction.normalized() * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process( delta: float ) -> void:
	if not is_on_floor():
		velocity += direction.normalized() * speed * delta
	else:
		if !done:
			done = true
			velocity = Vector2.ZERO
			var spwn = ResourceLoader.load( spawner ).instantiate()
			add_child.call_deferred( spwn )
			spwn.global_position = global_position
	
	move_and_slide()
