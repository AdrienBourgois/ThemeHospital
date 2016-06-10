
extends Node

var reception_desk = {
item_name = "TXT_RECEPTION_DESK",
item_price = 150,
item_id = 0
}

var bench = {
item_name = "TXT_BENCH",
item_price = 40,
item_id = 1
}

var drinks_machine = {
item_name = "TXT_DRINK",
item_price = 500,
item_id = 2
}

var fire_extinguisher = {
item_name = "TXT_FIRE",
item_price = 25,
item_id = 3
}

var radiator = {
item_name = "TXT_RADIATOR",
item_price = 20,
item_id = 4
}

var plant = {
item_name = "TXT_PLANT",
item_price = 5,
item_id = 5
}

var available_items = [reception_desk, bench, drinks_machine, fire_extinguisher, radiator, plant] setget ,getAvailableItems

func getAvailableItems():
	return available_items

func getItemFromId(id):
	for item in range ( available_items.size() ):
		if ( available_items[item].item_id == id ):
			return available_items[item]
	
	return null
	