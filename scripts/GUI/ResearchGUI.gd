
extends Control

onready var container = get_node("Container")
onready var total = get_node("Total")
var global_value = 0


func _ready():
	set_global_value()
	total.set_tooltip("TOOLTIP_RESEARCH_TOTAL")


func set_global_value():
	global_value = 0
	for i in range(container.get_child_count()):
		var value = container.get_child(i).get_value()
		global_value += value
		total.set_value(global_value)