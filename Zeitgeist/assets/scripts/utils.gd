extends Node
class_name utils

enum Segment {
	HEAD,
	BODY,
	TAIL
}

enum Pickup {
	HEAL,
	HEALTH,
	UPGRADE
}

enum Upgrade {
	HEALTH_UP,
	SMALL_HEAL,
	SLIDE,
	DOUBLE_JUMP,
}

static func GetDirection( direction ):
	if direction == 1:
		return "right"
	elif direction == -1:
		return "left"
	else:
		return "idle"

static func GetOppositeDirection( direction ):
	if direction == -1:
		return "right"
	elif direction == 1:
		return "left"
