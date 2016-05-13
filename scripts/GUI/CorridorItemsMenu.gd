
extends Control

onready var panel = get_node("Panel")
onready var bench = panel.get_node("Bench")
onready var plant = panel.get_node("Plant")
onready var radiator = panel.get_node("Radiator")
onready var drink = panel.get_node("Drink")
onready var fire = panel.get_node("Fire")

onready var drinkscn = preload("res://scenes/Entities/Objects/Object.scn")

var items_count_array = []
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

func updateValues():
	items_count_array.clear()
	items_count_array.append(bench.getValue())
	items_count_array.append(plant.getValue())
	items_count_array.append(radiator.getValue())
	items_count_array.append(drink.getValue())
	items_count_array.append(fire.getValue())

func countString(value):
	var count_string = "Count : " + str(value)

func _on_Accept_pressed():
	var array_idx = 0
	updateValues()
	
	for current in items_count_array:
		while (current > 0):
			current -= 1
			var node = drinkscn.instance()
			add_child(node)
		array_idx += 1
	resetvalues()
	self.hide()

func _on_Close_pressed():
	self.hide()