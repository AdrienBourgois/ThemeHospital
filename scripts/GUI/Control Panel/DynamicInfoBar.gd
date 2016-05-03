
extends Control

onready var control_panel = get_parent()
onready var buttons = get_node("Buttons")


func _ready():
	for idx in buttons.get_children():
		control_panel.init_connect(idx)