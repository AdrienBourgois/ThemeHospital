
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

func _on_LessBench_pressed():
	items_to_buy.BENCH = less(items_to_buy.BENCH)
	bench.get_node("Panel/Label").set_text("Count : " + str(items_to_buy.BENCH))

func _on_PlusBench_pressed():
	items_to_buy.BENCH += 1
	bench.get_node("Panel/Label").set_text("Count : " + str(items_to_buy.BENCH))

func _on_LessPlant_pressed():
	items_to_buy.PLANT = less(items_to_buy.PLANT)
	plant.get_node("Panel/Label").set_text("Count : " + str(items_to_buy.PLANT))

func _on_PlusPlant_pressed():
	items_to_buy.PLANT += 1
	plant.get_node("Panel/Label").set_text("Count : " + str(items_to_buy.PLANT))

func _on_LessRadiator_pressed():
	items_to_buy.RADIATOR = less(items_to_buy.RADIATOR)
	radiator.get_node("Panel/Label").set_text("Count : " + str(items_to_buy.RADIATOR))

func _on_PlusRadiator_pressed():
	items_to_buy.RADIATOR += 1
	radiator.get_node("Panel/Label").set_text("Count : " + str(items_to_buy.RADIATOR))

func _on_LessDrink_pressed():
	items_to_buy.DRINK = less(items_to_buy.DRINK)
	drink.get_node("Panel/Label").set_text("Count : " + str(items_to_buy.DRINK))

func _on_PlusDrink_pressed():
	items_to_buy.DRINK += 1
	drink.get_node("Panel/Label").set_text("Count : " + str(items_to_buy.DRINK))

func _on_LessFire_pressed():
	items_to_buy.FIRE = less(items_to_buy.FIRE)
	fire.get_node("Panel/Label").set_text("Count : " + str(items_to_buy.FIRE))

func _on_PlusFire_pressed():
	items_to_buy.FIRE += 1
	fire.get_node("Panel/Label").set_text("Count : " + str(items_to_buy.FIRE))
