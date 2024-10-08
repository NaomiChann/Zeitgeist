class_name ItemPickup
extends CharacterBody2D

const GRAVITY = 1000.0

@export_file( "*.json" ) var save_data : String

@export var pickup_type : utils.Pickup
@export var pickup_value : utils.Upgrade
@export var sprite : AnimatedSprite2D
@export var id : int = 0

func _ready():
	match pickup_type:
		utils.Pickup.HEAL:
			sprite.play( "heal" )
			velocity.y = -150.0
		utils.Pickup.HEALTH:
			sprite.play( "upgrade", 0 )
			sprite.frame = 0
		utils.Pickup.UPGRADE:
			sprite.play( "upgrade", 0 )
			sprite.frame = 1
			

func _physics_process( delta ):
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	move_and_slide()

func _on_pickup_hurtbox_area_entered( area ):
	if area.name == "player_hurtbox":
		print( get_parent().name )
		event_bus.ItemPickup.emit( pickup_type, pickup_value )
		if id != 0:
			if !world_state.scene_states.has( get_parent().name ):
				world_state.scene_states[get_parent().name] = []
			world_state.scene_states[get_parent().name].push_back( id )
		queue_free()
