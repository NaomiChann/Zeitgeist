extends Entity
class_name Player

const BASE_SPEED = 9 * TILES_PER_SECOND
const SLIDE_SPEED = 1.5 * BASE_SPEED
const JUMP_VELOCITY = -320.0

var speed = BASE_SPEED
var health = 300
var sliding = false
var attacking = false
var slideDirection = Vector2.RIGHT

var inputDirection = Vector2.ZERO
var lastDirection = Vector2.RIGHT
var inputJump = false
var inputJumpStart = false
var inputSlide = false
var inputSlideStart = false
var inputAttack = false

var incapacitated = false
var impactDirection = 1

var spawnPoint = Vector2.ZERO
var quadrant = Vector2.ZERO

@onready var healthMeter = $player_health

func _ready():
	spawnPoint = global_position
	state_machine.Initiate( self )
	state_machine_combat.Initiate( self )

func _physics_process( delta ):
	healthMeter.text = str( health )
	if health <= 0:
		global_position = spawnPoint
		health = 3
	
	if !incapacitated:
		PlayerInput()
	
	GetWall()
	
	# DEBUG
	$"../debug_hud/db_state".text = str( state_machine.current_state.name )
	$"../debug_hud/db_state2".text = str( state_machine_combat.current_state.name )
	$"../debug_hud/db_speed".text = "SPEED: " + str( speed ) + " (" + str( velocity ) + ")"
	$"../debug_hud/db_quadrant".text = "QUADRANT: " + str( GetQuadrant() )
	
	state_machine.Update( delta )
	state_machine_combat.Update( delta )
	move_and_slide()

func ApplyGravity( delta ):
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		velocity.y = clamp( velocity.y, -GRAVITY / 2, GRAVITY / 2 )

func PlayerInput():
	inputDirection = Vector2( Input.get_axis( "ui_left", "ui_right" ), Input.get_axis( "ui_down", "ui_up" ) )
	
	if Input.is_action_pressed( "slide" ):
		inputSlide = true
	else:
		inputSlide = false
	
	if Input.is_action_just_pressed( "slide" ):
		inputSlideStart = true
	else:
		inputSlideStart = false
	
	if Input.is_action_pressed( "jump" ):
		inputJump = true
	else:
		inputJump = false
	
	if Input.is_action_just_pressed( "jump" ):
		inputJumpStart = true
	else:
		inputJumpStart = false
	
	if Input.is_action_just_pressed( "attack" ):
		inputAttack = true
	else:
		inputAttack = false

func GetWall():
	for ray in raycasts.get_children():
		ray.force_raycast_update()
		if ray.is_colliding():
			if ray.target_position.x > 0:
				return Vector2.RIGHT
			else:
				return Vector2.LEFT
	return null

# feels ugly, there must be a cleaner way
func GetCeiling():
	for ray in raycasts.get_children():
		ray.force_raycast_update()
		if ray.is_colliding() and ( ray.name == "top_left" or ray.name == "top_right" ):
			return true
	return null

func GetQuadrant():
	quadrant = floor( global_position / 480 )
	return quadrant

func _on_player_hurtbox_area_entered( area ):
	health -= 1
	incapacitated = true
	if area.global_position.x > global_position.x:
		impactDirection = -1
	else:
		impactDirection = 1
