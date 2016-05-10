
extends Control

onready var control_panel = get_parent()
onready var in_game_gui = control_panel.get_parent()
onready var buttons = get_node("Buttons")
onready var label = get_node("Label")


func _ready():
	for idx in buttons.get_children():
		control_panel.initConnect(idx)

func display(txt):
	label.set_text(txt)

func _on_Charts_pressed():
	pass