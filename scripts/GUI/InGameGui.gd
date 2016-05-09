
extends Control

onready var control_panel = get_node("Control_panel")
onready var calendar = control_panel.get_node("Calendar")
onready var money = control_panel.get_node("Money")
onready var reputation = control_panel.get_node("Reputation")

func _ready():
	pass

func init():
	calendar.init()
	money.init()
	reputation.init()