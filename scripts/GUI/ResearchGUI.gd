
extends Control

var global_value = 0

func _ready():
	for i in range(get_node("Container").get_child_count()):
		var value = get_node("Container").get_child(i).get_value()
		global_value += value

