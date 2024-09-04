extends Node

var states = null
var player = null

func EnterState():
	pass

func ExitState():
	pass

func Update( delta ):
	return null

func PlayerMove():
	player.velocity.x = player.speed * player.inputDirection.x
	if player.inputDirection.x != 0:
		player.lastDirection = player.inputDirection
