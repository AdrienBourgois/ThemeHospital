
extends Panel

export var type = ""
export var value = 0
export var tooltip_value = ""

onready var values = get_node("values")

func _ready():
	get_node("type").set_text(type)
	
	values.set_text(str(value))
	values.set_tooltip(tooltip_value)
