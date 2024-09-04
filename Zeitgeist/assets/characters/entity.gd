class_name Entity
extends CharacterBody2D

const TILES_PER_SECOND = 16.0
const GRAVITY = 1000.0

@export var state_machine : StateMachine
@export var state_machine_combat : StateMachine
@export var raycasts : Node2D
@export var raycasts_ground : RayCast2D
@export var animation : AnimationPlayer
@export var animation_attack : AnimationPlayer
@export var hurtbox : Area2D
@export var detection_area : Area2D
@export var sprites : Node2D
