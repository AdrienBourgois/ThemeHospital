
extends Control

onready var control_panel = get_node("HUD/Control_panel")
onready var calendar = control_panel.get_node("Calendar")
onready var money = control_panel.get_node("Money")
onready var reputation = control_panel.get_node("Reputation")

func _ready():
	pass

func init():
	calendar.init()
	money.init()
	reputation.init()
	get_node("Charts/Objectives").init()

func _on_Corridor_items_pressed():
	pass # replace with function body