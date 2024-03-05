extends CharacterBody2D

const JUMP_VELOCITY = -320.0
const BASE_GRAVITY = 1000.0
const BASE_SPEED = 140.0
const SLIDE_SPEED = BASE_SPEED * 1.5

var gravity = BASE_GRAVITY
var speed = BASE_SPEED
var sliding = false
var slideDirection = Vector2.RIGHT

var stateCurr = null
var statePrev = null

var inputDirection = Vector2.ZERO
var lastDirection = Vector2.RIGHT
var inputJump = false
var inputJumpStart = false
var inputSlide = false
var inputSlideStart = false

var recordedPositions = []

@onready var states = $States
@onready var raycasts = $Raycasts

func _ready():
	for state in states.get_children():
		state.states = states
		state.player = self
	
	statePrev = states.idle
	stateCurr = states.idle

func _physics_process( delta ):
	PlayerInput()
	GetWall()
	ChangeState( stateCurr.Update( delta ) )
	RecordPosition()
	
	# DEBUG
	$"../DB_UI/DB_STATE".text = str( stateCurr.get_name() )
	$"../DB_UI/DB_SPEED".text = "SPEED: " + str( speed ) + " (" + str( velocity ) + ")"
	
	move_and_slide()

func ApplyGravity( delta ):
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = clamp( velocity.y, -BASE_GRAVITY / 2, BASE_GRAVITY / 2 )

func ChangeState( inputState ):
	if inputState != null:
		statePrev = stateCurr
		stateCurr = inputState
		
		statePrev.ExitState()
		stateCurr.EnterState()

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

func GetWall():
	for ray in raycasts.get_children():
		ray.force_raycast_update()
		if ray.is_colliding():
			if ray.target_position.x > 0:
				return Vector2.RIGHT
			else:
				return Vector2.LEFT
	return null

func RecordPosition():
	recordedPositions.push_back( global_position )
	if len( recordedPositions ) > 32:
		recordedPositions.pop_front()
