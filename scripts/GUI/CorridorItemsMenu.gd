
extends Control

onready var panel = get_node("Panel")
onready var bench = panel.get_node("Bench")
onready var plant = panel.get_node("Plant")
onready var radiator = panel.get_node("Radiator")
onready var drink = panel.get_node("Drink")
onready var fire = panel.get_node("Fire")

onready var items_to_buy = {
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

func less(value):
	value -= 1
	if (value < 0):
		value = 0
	return value

func plus(value):
	value += 1

func _on_Drink_pressed():
	pass # replace with function body

func _on_Close_pressed():
	self.hide()

func _on_LessBench_pressed():
	less(items_to_buy.BENCH)
	bench.get_node("Panel/Label").set_text(countString(items_to_buy.BENCH))

func _on_PlusBench_pressed():
	plus(items_to_buy.BENCH)
	bench.get_node("Panel/Label").set_text(countString(items_to_buy.BENCH))

func _on_LessPlant_pressed():
	less(items_to_buy.PLANT)

func _on_PlusPlant_pressed():
	plus(items_to_buy.PLANT)

func _on_LessRadiator_pressed():
	less(items_to_buy.RADIATOR)

func _on_PlusRadiator_pressed():
	plus(items_to_buy.RADIATOR)

func _on_LessDrink_pressed():
	less(items_to_buy.DRINK)

func _on_PlusDrink_pressed():
	plus(items_to_buy.DRINK)

func _on_LessFire_pressed():
	less(items_to_buy.FIRE)

func _on_PlusFire_pressed():
	plus(items_to_buy.FIRE)
