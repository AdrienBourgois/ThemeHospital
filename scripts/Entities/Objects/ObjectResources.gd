
extends Node

var objectscn = preload("res://scenes/Entities/Objects/Object.scn")
var benchscn = preload("res://scenes/Entities/Objects/Bench.scn")
var plantscn = preload("res://scenes/Entities/Objects/Plant.scn")
var radiatorscn = preload("res://scenes/Entities/Objects/Radiator.scn")
var drinkscn = preload("res://scenes/Entities/Objects/DrinkMachine.scn") 
var firescn = preload("res://scenes/Entities/Objects/Fire.scn")
var deskscn = preload("res://scenes/Entities/Objects/Desk.scn")
var crash_trolley_scn = preload("res://scenes/Entities/Objects/CrashTrolley.scn")
var pharmacy_cabinet_scn = preload("res://scenes/Entities/Objects/PharmacyCabinet.scn")
var array_scn = [benchscn, plantscn, radiatorscn, drinkscn, firescn]

var toiletsscn = preload("res://scenes/Entities/Objects/Toilets.scn")

func createObject(name):
	var node
	if (name == "Bench"):
		node = benchscn.instance()
	elif (name == "Plant"):
		node = plantscn.instance()
	elif (name == "Radiator"):
		node = radiatorscn.instance()
	elif (name == "Drink" or name == "DrinkMachine"):
		node = drinkscn.instance()
	elif (name == "Fire" or name == "FireExtinguisher"):
		node = firescn.instance()
	elif (name == "Desk"):
		node = deskscn.instance()
	else:
		node = objectscn.instance()
	return node

func createRoomObject(name):
	var node
	if (name == "ROOM_GP"):
		node = deskscn.instance()
	elif (name == "ROOM_TOILETS"):
		node = toiletsscn.instance()
	elif (name == "ROOM_GENERAL_DIAGNOSIS"):
		node = crash_trolley_scn.instance()
	elif (name == "ROOM_PHARMACY"):
		node = pharmacy_cabinet_scn.instance()
	else:
		node = objectscn.instance()
	return node

func returnPlant():
	var node = plantscn.instance()
	return node