extends Control

export var value = 20
export var text = ""

onready var node_bar = get_node("ProgressBar")
onready var node_label = get_node("Label")

func _ready():
	node_bar.set_value(value)
	node_label.set_text(text)


func _on_ButtonMore_pressed():
	value += 1
	node_bar.set_value(value)
	
	return value

func _on_ButtonLess_pressed():
	value -= 1
	node_bar.set_value(value)
	
	return value

func get_value():
	return value