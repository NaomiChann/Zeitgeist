extends CharacterBody2D
class_name Entity

const TILES_PER_SECOND = 15.0 # roughly
const GRAVITY = 1000.0

@export var state_machine : StateMachine
@export var state_machine_combat : StateMachine
@export var raycasts : Node
@export var raycasts_ground : Node
@export var animation : Node
@export var hurtbox : Node
