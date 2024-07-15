class_name Enemy
extends Entity

const BASE_SPEED = 2 * TILES_PER_SECOND

var speed = BASE_SPEED
var hitPoints = 3
var attack = true
var impactDirection = 1
var direction = Vector2.LEFT

@onready var healthMeter = $health

func _ready():
	state_machine.Initiate( self )

func _physics_process( delta ):
	healthMeter.text = str( hitPoints )
	$db_state.text = str( state_machine.current_state.name )
	if hitPoints <= 0:
		queue_free()
	
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

func _on_enemy_hurtbox_area_entered( area ):
	if area.name == "player_hitbox":
		hitPoints -= 1
		if area.global_position.x > global_position.x:
			impactDirection = -1
		else:
			impactDirection = 1
