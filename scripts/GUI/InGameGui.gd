
extends Control

onready var control_panel = get_node("HUD/Control_panel")
onready var objectives = get_node("Charts/Objectives")
onready var menu = get_node("InGameMenu")
onready var hire_selector = get_node("HUD/Staff_gui/TabContainer")

var window_opened = false

func _ready():
	set_process_input(true)

func _input(event):
	if (event.is_action_released("ui_cancel")):
		if (window_opened):
			window_opened = false
			hideWindows()
		else:
			menu.set_hidden(not menu.is_hidden())

func hideWindows():
	menu.hide()
	hire_selector.hide()