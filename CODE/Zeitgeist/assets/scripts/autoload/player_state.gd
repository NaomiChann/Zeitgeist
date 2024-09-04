extends Node

var max_health : int = 4
var health : int = max_health
var animation_frame : int
var state : State
var velocity : Vector2
var speed : float
var inputSlide : bool
var inputJump : bool

var flag_dash : bool = false
var flag_djump : bool = false
