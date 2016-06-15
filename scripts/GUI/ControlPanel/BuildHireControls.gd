
extends Control

onready var control_panel = get_parent()
onready var buttons = get_node("Buttons")

onready var game = get_node("/root/Game")
#onready var rooms_menu = get_node("../../RoomsMenu")
onready var rooms_menu = preload("res://scenes/GUI/RoomsMenu.scn")
#onready var staff_gui = get_node("../../Staff_gui")
onready var staff_gui = preload("res://scenes/GUI/InGameGUI/HUD/StaffGUI.scn")
onready var shop_menu = preload("res://scenes/GUI/ShopMenu.scn")

var last_button_pressed = {
build = false,
corridor_items = false,
edit = false,
hire = false
}

var current_window_open = null
var window_opened = false

func _ready():
	for idx in buttons.get_children():
		control_panel.initConnect(idx)

func _on_Hire_pressed():
	if ( last_button_pressed.hire ):
		hideCurrentWindow()
	else:
		hideCurrentWindow()
		last_button_pressed.hire = true
		current_window_open = staff_gui.instance()
		game.scene.add_child(current_window_open)
#		staff_gui.set_hidden(not staff_gui.is_hidden())

func _on_Build_pressed():
	if ( last_button_pressed.build ):
		hideCurrentWindow()
	else:
		hideCurrentWindow()
		current_window_open = rooms_menu.instance()
		last_button_pressed.build = true
		game.scene.add_child(current_window_open)
#		rooms_menu.set_hidden(not rooms_menu.is_hidden())

func _on_Corridor_items_pressed():
	if ( !last_button_pressed.corridor_items ):
		hideCurrentWindow()
		current_window_open = shop_menu.instance()
		game.scene.add_child(current_window_open)
		last_button_pressed.corridor_items = true
	else:
		hideCurrentWindow()


func _on_Build_mouse_enter():
	if ( !last_button_pressed.build ):
		game.feedback.display("TUTO_BUILD_ROOMS")


func _on_Corridor_items_mouse_enter():
	game.feedback.display("TUTO_CORRIDOR_ITEMS")


func _on_Hire_mouse_enter():
	game.feedback.display("TUTO_HIRE")

func resetLastButtonPressed():
	last_button_pressed.build = false
	last_button_pressed.corridor_items = false
	last_button_pressed.edit = false
	last_button_pressed.hire = false

func hideCurrentWindow():
	if ( current_window_open != null ):
		if ( last_button_pressed.corridor_items || last_button_pressed.hire || last_button_pressed.build):
			current_window_open.freeScene()
		else:
			current_window_open.set_hidden(true)
		current_window_open = null
		
		resetLastButtonPressed()