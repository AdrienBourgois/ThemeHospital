
extends Control

onready var control_panel = get_parent()
onready var buttons = get_node("Buttons")

onready var staff_gui = get_node("../../../Staff_gui")

func _ready():
	for idx in buttons.get_children():
		control_panel.initConnect(idx)

func _on_Hire_pressed():
	staff_gui.show()
