@icon( "res://game/scripts_general/classes/class_icons/fsm.svg" )
class_name StateMachine
extends Node

@export var starting_state : State

var current_state : State

func Initiate( entity : Entity ):
	for state in get_children():
		state.entity = entity
	
	ChangeState( starting_state )

func ChangeState( new_state : State ):
	if current_state:
		current_state.ExitState()
	
	current_state = new_state
	current_state.EnterState()

func Update( delta ):
	var new_state = current_state.Update( delta )
	
	if new_state:
		ChangeState( new_state )
