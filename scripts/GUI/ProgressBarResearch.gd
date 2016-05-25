extends Control

export var value = 20
export var text = ""

onready var node_bar = get_node("ProgressBar")
onready var node_label = get_node("Label")
onready var node_parent_research = get_parent().get_parent()

func _ready():
	node_bar.set_value(value)
	node_label.set_text(text)


func _on_ButtonMore_pressed():
	addition()
	node_bar.set_value(value)
	node_parent_research.set_global_value()
	
	return value

func _on_ButtonLess_pressed():
	substraction()
	node_bar.set_value(value)
	node_parent_research.set_global_value()
	
	return value

func addition():
	if (node_parent_research.global_value < 100):
		value += 1
		return value
	else:
		return

func substraction():
	if (node_parent_research.global_value > 0 && value != 0):
		value -= 1
		return value
	else:
		return

func get_value():
	return value