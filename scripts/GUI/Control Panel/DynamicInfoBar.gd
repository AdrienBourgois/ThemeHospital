
extends Control

onready var control_panel = get_parent()
onready var hud = control_panel.get_parent()
onready var buttons = get_node("Buttons")
onready var label = get_node("Label")

onready var status = get_node("../../../Status")
onready var town_map = get_node("../../../TownMap")

func _ready():
	for idx in buttons.get_children():
		control_panel.initConnect(idx)

func display(txt):
	label.set_text(txt)

func _on_Status_pressed():
	hud.hide()
	status.show()

func _on_Town_Map_pressed():
	hud.hide()
	town_map.show()
