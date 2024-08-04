extends Node
class_name utils

static func GetDirection( direction ):
	if direction == 1:
		return "right"
	elif direction == -1:
		return "left"
	else:
		return "idle"

static func GetChildrenByClass( node : Node, name_of_class : String ):
	var children_of_class : Array = []
	
	for child in node.get_children():
		if child.is_class( name_of_class ):
			children_of_class.push_back( child )
	
	return children_of_class
