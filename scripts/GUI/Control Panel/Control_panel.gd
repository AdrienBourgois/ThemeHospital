
extends Panel

onready var dynamic_info_bar_label = get_node("Dynamic_info_bar/Label")
onready var dynamic_info_bar_buttons = get_node("Dynamic_info_bar/Buttons")
onready var rooms_menu = get_node("../../RoomsMenu")
onready var corridor_items_menu = get_node("../../CorridorItemsMenu")

var window_opened = false

func _ready():
	pass

func initConnect(node):
	node.connect("mouse_enter", self, "_on_Control_panel_mouse_enter")
	node.connect("mouse_exit", self, "_on_Control_panel_mouse_exit")

func _on_Control_panel_mouse_enter():
	dynamic_info_bar_label.hide()
	dynamic_info_bar_buttons.show()


func _on_Control_panel_mouse_exit():
	dynamic_info_bar_label.show()
	dynamic_info_bar_buttons.hide()

func _on_Build_pressed():
	if (get_node("../../Confirmation").is_hidden()):
		rooms_menu.set_hidden(not rooms_menu.is_hidden())
	else:
		return


func _on_Corridor_items_pressed():
	corridor_items_menu.set_hidden(not corridor_items_menu.is_hidden())
	if (!corridor_items_menu.is_hidden()):
		window_opened = true
