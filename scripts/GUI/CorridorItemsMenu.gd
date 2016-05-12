
extends Control

onready var panel = get_node("Panel")
onready var bench = panel.get_node("Bench")
onready var plant = panel.get_node("Plant")
onready var radiator = panel.get_node("Radiator")
onready var drink = panel.get_node("Drink")
onready var fire = panel.get_node("Fire")

onready var drinkscn = preload("res://scenes/Entities/Objects/Object.scn")

var drink_array = []
var items_to_buy = {
BENCH = 0,
PLANT = 0,
RADIATOR = 0,
DRINK = 0,
FIRE = 0
}

func _ready():
	self.hide()

func updateValues(node):
	pass

func countString(value):
	var count_string = "Count : " + str(value)

func _on_Accept_pressed():
	var node = drinkscn.instance()
	add_child(node)
	self.hide()

func checkIsEmpty():
	pass
	
func less(value):
	value -= 1
	if (value < 0):
		value = 0
	return value
	
func _on_Close_pressed():
	self.hide()

func _on_Drink_pressed():
	_on_PlusDrink_pressed()
