
extends Control

onready var container = get_node("Container")
var global_value = 0

func _ready():
	set_global_value()

func set_global_value():
	global_value = 0
	for i in range(container.get_child_count()):
		var value = container.get_child(i).get_value()
		global_value += value
		get_node("Total").set_value(global_value)