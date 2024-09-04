extends Entity

@export var hitPoints : int
@export var damage : int

const BASE_SPEED = 0.5 * TILES_PER_SECOND

var speed = BASE_SPEED
var attack = true
var direction = Vector2.LEFT
var last_seen_target : Vector2
var times_idled = 0
var vulnerable = false

func _ready():
	state_machine.Initiate( self )

func _physics_process( delta ):
	if hitPoints <= 0:
		queue_free()
	$Label.text = str( hitPoints )
	state_machine.Update( delta )
	move_and_slide()

func ApplyGravity( delta ):
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		velocity.y = clamp( velocity.y, -GRAVITY / 2, GRAVITY / 2 )

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
	if area.name == "player_hitbox" and vulnerable:
		hitPoints -= 1