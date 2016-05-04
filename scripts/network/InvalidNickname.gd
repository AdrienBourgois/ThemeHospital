
extends Control

onready var nickname_node = get_node("invalid_nickname")

func _ready():
	nickname_node.set_hidden(false)
	nickname_node.get_ok().grab_focus()

func _on_invalid_nickname_confirmed():
	queue_free()
