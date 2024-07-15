extends Node
class_name utils

static func GetDirection( direction ):
	if direction == 1:
		return "right"
	elif direction == -1:
		return "left"
	else:
		return "idle"
