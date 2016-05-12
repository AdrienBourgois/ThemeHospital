
extends Control

onready var panel = get_node("Panel")
onready var bench = panel.get_node("Bench")
onready var plant = panel.get_node("Plant")
onready var radiator = panel.get_node("Radiator")
onready var drink = panel.get_node("Drink")
onready var fire = panel.get_node("Fire")

onready var bench_label = bench.get_node("Label")
onready var plant_label = plant.get_node("Label")
onready var radiator_label = radiator.get_node("Label")
onready var drink_label = drink.get_node("Label")
onready var fire_label = fire.get_node("Label")
onready var label_array = [bench_label, plant_label, radiator_label, drink_label, fire_label]

onready var drinkscn = preload("res://scenes/Entities/Objects/Object.scn")

var items_count_array = []

func _ready():
	self.hide()

func updateValues():
	items_count_array.clear()
	items_count_array.append(bench.getValue())
	items_count_array.append(plant.getValue())
	items_count_array.append(radiator.getValue())
	items_count_array.append(drink.getValue())
	items_count_array.append(fire.getValue())

func resetvalues():
	var default_text = "Count : 0"
	bench.setValue(0)
	plant.setValue(0)
	radiator.setValue(0)
	drink.setValue(0)
	fire.setValue(0)
	for current in label_array:
		current.set_text(default_text)

func countString(value):
	var count_string = "Count : " + str(value)

func _on_Accept_pressed():
	updateValues()
	for current in items_count_array:
		while (current > 0):
			print("TAMERE")
			current -= 1
	resetvalues()
	self.hide()

func _on_Close_pressed():
	self.hide()
