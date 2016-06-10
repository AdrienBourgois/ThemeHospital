
extends Control

onready var control_panel = get_parent()
onready var buttons = get_node("Buttons")

onready var game = get_node("/root/Game")
onready var rooms_menu = get_node("../../RoomsMenu")
onready var corridor_items_menu = get_node("../../CorridorItemsMenu")
onready var staff_gui = get_node("../../Staff_gui")
onready var shop_menu = preload("res://scenes/GUI/ShopMenu.scn")

var window_opened = false

func _ready():
	for idx in buttons.get_children():
		control_panel.initConnect(idx)

func _on_Hire_pressed():
	staff_gui.set_hidden(not staff_gui.is_hidden())

func _on_Build_pressed():
	rooms_menu.set_hidden(not rooms_menu.is_hidden())

func _on_Corridor_items_pressed():
	game.scene.add_child(shop_menu.instance())

func _on_Build_mouse_enter():
	game.feedback.display("TUTO_BUILD_ROOMS")


func _on_Corridor_items_mouse_enter():
	game.feedback.display("TUTO_CORRIDOR_ITEMS")


func _on_Hire_mouse_enter():
	game.feedback.display("TUTO_HIRE")