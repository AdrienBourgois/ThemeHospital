
extends Panel

onready var dynamic_info_bar_label = get_node("Dynamic_info_bar/Label")
onready var dynamic_info_bar_buttons = get_node("Dynamic_info_bar/Buttons")

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