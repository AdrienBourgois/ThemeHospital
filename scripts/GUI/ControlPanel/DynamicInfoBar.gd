extends Control

onready var game = get_node("/root/Game")
onready var camera = game.scene.camera
onready var control_panel = get_parent()
onready var hud = control_panel.get_parent()
onready var buttons = get_node("Buttons")
onready var label = get_node("Label")

onready var status = get_node("../../../Status")
#onready var town_map = get_node("../../../TownMap")
onready var research = get_node("../../../Research")
onready var casebook = get_node("../../../Casebook")
onready var town_map = preload("res://scenes/GUI/DynamicInfoBarPanels/TownMap.scn")

func _ready():
	for idx in buttons.get_children():
		control_panel.initConnect(idx)

func display(txt):
	label.set_text(txt)

func _on_Status_pressed():
	hud.hide()
	status.show()
	camera.pause = true

func _on_Town_Map_pressed():
	hud.hide()
	game.scene.add_child(town_map.instance())
#	town_map.show()
	camera.pause = true

func _on_Research_pressed():
	hud.hide()
	research.show()
	camera.pause = true

func _on_Drug_Casebook_pressed():
	hud.hide()
	casebook.show()
	camera.pause = true