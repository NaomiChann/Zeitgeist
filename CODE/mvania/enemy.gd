extends CharacterBody2D

# Jobbers
const BASE_GRAVITY = 1000.0
const BASE_SPEED = 20.0
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
	
	# Define a direção inicial aleatória
	slideDirection = [Vector2.RIGHT, Vector2.LEFT][randi() % 2]

func _physics_process(delta):
	if is_on_floor():
		if slideDirection == Vector2.RIGHT:
			inputDirection = Vector2.RIGHT
		else:
			inputDirection = Vector2.LEFT
	else:
		# Se não estiver no chão, muda de direção
		slideDirection = slideDirection * -1
		inputDirection = slideDirection

	inputJump = false
	inputSlide = false

	ChangeState(stateCurr.Update(delta))

	move_and_slide()

func ApplyGravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.y = clamp(velocity.y, -BASE_GRAVITY / 2, BASE_GRAVITY / 2)

func ChangeState(inputState):
	if inputState != null:
		statePrev = stateCurr
		stateCurr = inputState

		statePrev.ExitState()
		stateCurr.EnterState()

func GetWall():
	for ray in raycasts.get_children():
		ray.force_raycast_update()
		if ray.is_colliding():
			if ray.target_position.x > 0:
				return Vector2.RIGHT
			else:
				return Vector2.LEFT
	return null
