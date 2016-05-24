
extends Node

var objectscn = preload("res://scenes/Entities/Objects/Object.scn")
var benchscn = preload("res://scenes/Entities/Objects/Bench.scn")
var plantscn = preload("res://scenes/Entities/Objects/Plant.scn")
var radiatorscn = preload("res://scenes/Entities/Objects/Radiator.scn")
var drinkscn = preload("res://scenes/Entities/Objects/DrinkMachine.scn") 
var firescn = preload("res://scenes/Entities/Objects/Fire.scn")

func createObject(name):
	var node
	if (name == "Object"):
		node = objectscn.instance()
	elif (name == "Bench"):
		node = benchscn.instance()
	elif (name == "Plant"):
		node = plantscn.instance()
	elif (name == "Radiator"):
		node = radiatorscn.instance()
	elif (name == "Drink" or name == "DrinkMachine"):
		node = drinkscn.instance()
	elif (name == "Fire" or name == "FireExtinguisher"):
		node = firescn.instance()
	return node

func returnPlant():
	var node = plantscn.instance()
	return node