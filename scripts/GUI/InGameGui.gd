
extends Control

onready var control_panel = get_node("HUD/Control_panel")
onready var calendar = control_panel.get_node("Calendar")
onready var money = control_panel.get_node("Money")
onready var reputation = control_panel.get_node("Reputation")
onready var corridor_items_menu = get_node("HUD/CorridorItemsMenu")
onready var objectives = get_node("Charts/Objectives")
onready var menu = get_node("InGameMenu")

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
	corridor_items_menu.hide()

func init():
	calendar.init()
	money.init()
	reputation.init()
#	objectives.init()

func _on_Corridor_items_pressed():
	corridor_items_menu.set_hidden(not corridor_items_menu.is_hidden())
	if (!corridor_items_menu.is_hidden()):
		window_opened = true
