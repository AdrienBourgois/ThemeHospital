
extends Control

onready var control_panel = get_node("HUD/Control_panel")
onready var calendar = control_panel.get_node("Calendar")
onready var money = control_panel.get_node("Money")
onready var reputation = control_panel.get_node("Reputation")
onready var corridor_items_menu = get_node("HUD/CorridorItemsMenu")
onready var menu = get_node("InGameMenu")

func _ready():
	pass

func init():
	calendar.init()
	money.init()
	reputation.init()
	get_node("Charts/Objectives").init()

func _input(event):
	if (event.is_action_released("ui_cancel")):
		corridor_items_menu.hide()

func _on_Corridor_items_pressed():
	corridor_items_menu.set_hidden(not corridor_items_menu.is_hidden())
	set_process_input(true)
