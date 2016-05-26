
extends Panel

export var type = ""
export var value = 0

func _ready():
	get_node("type").set_text(type)
	get_node("values").set_text(str(value))
