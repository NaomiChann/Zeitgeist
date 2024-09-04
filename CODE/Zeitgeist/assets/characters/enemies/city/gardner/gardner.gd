extends Entity

@export var hitPoints : int
@export var damage : int

const BASE_SPEED = 2 * TILES_PER_SECOND

var speed = BASE_SPEED
var attack = true
var player_detected = false
var direction = Vector2.LEFT
var starting_position : Vector2
var last_seen_target : Vector2
var lastDirection = Vector2.RIGHT

func _ready():
	state_machine.Initiate( self )
	starting_position = global_position

func _physics_process( delta ):
	if hitPoints <= 0:
		var explosion = ResourceLoader.load( "res://assets/objects/vfx/explosion/explosion_vfx.tscn" ).instantiate()
		explosion.global_position = global_position
		get_parent().add_child( explosion )
		if randi() % 5 == 0:
			var heal = ResourceLoader.load( "res://assets/objects/pickup/pickup.tscn" ).instantiate()
			heal.global_position = global_position
			get_parent().add_child( heal )
		queue_free()
	
	state_machine.Update( delta )
	move_and_slide()

func GetWall():
	for ray in raycasts.get_children():
		ray.force_raycast_update()
		if ray.is_colliding():
			if ray.target_position.x > 0:
				return Vector2.RIGHT
			else:
				return Vector2.LEFT
	return null

func GetLedge():
	raycasts_ground.force_raycast_update()
	if !raycasts_ground.is_colliding():
		return true
	
	return null

func CheckOverlaps():
	for area in detection_area.get_overlapping_areas():
		if area.name == "player_hurtbox":
			last_seen_target = area.global_position
			return true
	return false

func _on_enemy_hurtbox_area_entered( area ):
	if area.name == "player_hitbox" or area.name == "player_hurtbox":
		hitPoints = 0
