
extends Control

onready var items_to_buy = {
BENCH = 0,
PLANT = 0,
RADIATOR = 0,
DRINK = 0,
FIRE = 0
}

func _ready():
	self.hide()

func less(value):
	value -= 1
	if (value < 0):
		value = 0
	return value

func _on_Drink_pressed():
	pass # replace with function body

func _on_Close_pressed():
	self.hide()
