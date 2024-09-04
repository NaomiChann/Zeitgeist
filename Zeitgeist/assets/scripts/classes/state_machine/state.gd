@icon( "res://assets/scripts/classes/class_icons/fsm_state.svg" )
class_name State
extends Node

var entity : Entity

func EnterState():
	pass

func ExitState():
	pass

func Update( _delta ):
	pass

func Move():
	entity.velocity.x = entity.speed * entity.inputDirection.x
	if entity.inputDirection.x != 0:
		entity.sprites.scale.x = entity.inputDirection.x
		entity.lastDirection.x = entity.inputDirection.x
