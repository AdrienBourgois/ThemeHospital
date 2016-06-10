
extends Panel

onready var game = get_node("/root/Game")
onready var dynamic_info_bar_label = get_node("Dynamic_info_bar/Label")
onready var dynamic_info_bar_buttons = get_node("Dynamic_info_bar/Buttons")
onready var bank_manager = preload("res://scenes/GUI/DynamicInfoBarPanels/BankManagement.scn")

func initConnect(node):
	node.connect("mouse_enter", self, "_on_Control_panel_mouse_enter")
	node.connect("mouse_exit", self, "_on_Control_panel_mouse_exit")

func _on_Control_panel_mouse_enter():
	dynamic_info_bar_label.hide()
	dynamic_info_bar_buttons.show()
	game.feedback.display("TUTO_INFO_BAR")


func _on_Control_panel_mouse_exit():
	dynamic_info_bar_label.show()
	dynamic_info_bar_buttons.hide()

func _on_Bank_pressed():
	game.scene.add_child(bank_manager.instance())

func _on_Bank_mouse_enter():
	game.feedback.display("TUTO_BANK")