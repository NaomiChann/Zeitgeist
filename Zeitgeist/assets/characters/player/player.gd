@icon( "res://assets/scripts/classes/class_icons/plr.svg" )
class_name Player
extends Entity

@export var slowmo : bool
@export var iframes_timer : Timer
@export var trail : Node2D
@export var heal_audio : AudioStreamPlayer

const BASE_SPEED = 9 * TILES_PER_SECOND
const SLIDE_SPEED = 1.5 * BASE_SPEED
const JUMP_VELOCITY = -20.5 * TILES_PER_SECOND

var speed = BASE_SPEED
var max_health : int = 4
var health : int = max_health
var sliding = false
var attacking = false
var slideDirection = Vector2.RIGHT
var immune : bool = false

var inputDirection = Vector2.ZERO
var lastDirection = Vector2.RIGHT
var inputJump = false
var inputJumpStart = false
var inputSlide = false
var inputSlideStart = false
var inputAttack = false

var incapacitated = false
var can_jump = false
var impactDirection = 1

@export var flag_dash : bool = false
@export var flag_djump : bool = false

var quadrant : Vector2 = Vector2.ZERO
var previous_quadrant : Vector2 = Vector2( -1, -1 )

func _ready():
	if slowmo:
		Engine.time_scale = 0.5
	event_bus.OnLoadzoneTriggered.connect( StoreContinuity, CONNECT_ONE_SHOT )
	event_bus.SpawnPlayer.connect( LoadContinuity, CONNECT_ONE_SHOT )
	event_bus.ItemPickup.connect( HandlePickup )
	state_machine.Initiate( self )
	state_machine_combat.Initiate( self )

func _physics_process( delta ):
	if Input.is_action_pressed( "ui_end" ) and Input.is_action_pressed( "ui_text_backspace" ):
		Heal( -999 )
		incapacitated = true
	
	if !incapacitated:
		PlayerInput()
	
	GetWall()
	state_machine.Update( delta )
	state_machine_combat.Update( delta )
	move_and_slide()
	GetQuadrant()

func ApplyGravity( delta ):
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		velocity.y = clamp( velocity.y, -GRAVITY / 2, GRAVITY / 2 )

func PlayerInput():
	inputDirection = Vector2( Input.get_axis( "ui_left", "ui_right" ), Input.get_axis( "ui_down", "ui_up" ) )
	
	if flag_dash:
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
	quadrant = floor( global_position / 256 ).clamp( Vector2.ZERO, get_parent().room_size - Vector2.ONE )
	
	if quadrant != previous_quadrant:
		event_bus.UpdateDisplayMap.emit( get_parent().room_coordinates + quadrant )
	previous_quadrant = quadrant

func StoreContinuity():
	player_state.health = health
	player_state.max_health = max_health
	player_state.velocity = velocity
	player_state.speed = speed
	player_state.inputSlide = inputSlide
	player_state.inputJump = inputJump
	player_state.flag_dash = flag_dash
	player_state.flag_djump = flag_djump
	scene_manager.PausePlayer( true )

func LoadContinuity( spawn_point : Vector2 ):
	health = player_state.health
	max_health = player_state.max_health
	velocity = player_state.velocity
	speed = player_state.speed
	inputSlide = player_state.inputSlide
	inputJump = player_state.inputJump
	global_position = spawn_point
	flag_dash = player_state.flag_dash
	flag_djump = player_state.flag_djump
	scene_manager.PausePlayer( true )

func SetTrail( status : bool ):
	trail.Setup( status )

func HandlePickup( pickup_type : utils.Pickup, pickup_value : utils.Upgrade ):
	match pickup_type:
		utils.Pickup.HEAL:
			Heal( pickup_value )
		utils.Pickup.HEALTH:
			IncreaseHealth()
		utils.Pickup.UPGRADE:
			UnlockUpgrade( pickup_value )

func Heal( amount : int ):
	health += amount
	
	if amount > 0:
		heal_audio.play()
	
	if health > max_health:
		health = max_health
	elif health < 0:
		health = 0
	event_bus.UpdateDisplayHealth.emit( health )
	

func IncreaseHealth():
	max_health += 1
	health = max_health
	event_bus.UpdateDisplayHealth.emit( health, true )

func UnlockUpgrade( upgrade : utils.Upgrade ):
	match upgrade:
		utils.Upgrade.SLIDE:
			flag_dash = true
		utils.Upgrade.DOUBLE_JUMP:
			flag_djump = true

func CheckOverlaps():
	if !immune and hurtbox.get_overlapping_areas().size() > 0:
		var area = hurtbox.get_overlapping_areas()[0]
		
		if area.global_position.x > global_position.x:
			impactDirection = -1
		else:
			impactDirection = 1
		
		Heal( -area.get_parent().damage )
		event_bus.UpdateDisplayHealth.emit( health )
		incapacitated = true
		iframes_timer.start( 1.5 )
		immune = true
		$hit_anim.play( "hit" )

func _on_iframes_timer_timeout():
	immune = false
	CheckOverlaps()

func _on_player_hurtbox_area_entered( area ):
	if !immune:
		if area.global_position.x > global_position.x:
			impactDirection = -1
		else:
			impactDirection = 1
		
		Heal( -area.get_parent().damage )
		event_bus.UpdateDisplayHealth.emit( health )
		incapacitated = true
		iframes_timer.start( 1.5 )
		immune = true
		$hit_anim.play( "hit" )
